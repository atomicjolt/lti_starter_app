class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  devise :two_factor_authenticatable,
         otp_secret_encryption_key: Rails.application.secrets.otp_secret_encryption_key

  devise :two_factor_backupable, otp_backup_code_length: 32,
         otp_number_of_backup_codes: 10

  has_many :authentications, dependent: :destroy, inverse_of: :user
  has_many :permissions, dependent: :destroy
  has_many :roles, through: :permissions

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, password_strength: { use_dictionary: true }, allow_nil: true

  enum create_method: %i{sign_up oauth lti}

  scope :oauth_user, -> { where(create_method: create_methods[:oauth]) }
  scope :sign_up_user, -> { where(create_method: create_methods[:sign_up]) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }
  scope :with_role_id, ->(role_ids) { joins(:permissions).where(permissions: { role_id: role_ids }) }
  scope :by_name, -> { order(:name) }
  scope :by_email, -> { order(:email) }

  def display_name
    name || email
  end

  def first_name
    display_name.split(" ").first
  end

  def last_name
    display_name.split(" ").last
  end

  def self.create_on_tenant(application_instance, user)
    existing_user = Apartment::Tenant.switch(application_instance.tenant) do
      User.find_by(email: user.email, lti_user_id: user.lti_user_id)
    end

    return existing_user if existing_user.present?

    user_permissions = user.permissions.load.includes(:role).load
    Apartment::Tenant.switch(application_instance.tenant) do
      user_dup = User.find_or_initialize_by(
        lti_user_id: user.lti_user_id,
      )
      user_dup.update(user.copy_attributes)

      if user_dup.password.blank?
        user_dup.password = Devise.friendly_token(72)
        user_dup.password_confirmation = user_dup.password
      end

      user_dup.save

      user_permissions.each do |permission|
        role = Role.find_or_create_by(name: permission.role.name)
        Permission.find_or_create_by(
          role_id: role.id,
          user_id: user_dup.id,
          context_id: permission.context_id,
        )
      end

      user_dup
    end
  end

  def copy_attributes
    attributes.except(
      "id",
      "created_at",
      "updated_at",
    )
  end

  ####################################################
  #
  # OTP related methods
  # https://web.archive.org/web/20210719115534/https://www.jamesridgway.co.uk/implementing-a-two-step-otp-u2f-login-workflow-with-rails-and-devise/
  #

  # Generate an OTP secret it it does not already exist
  def generate_two_factor_secret_if_missing!
    return unless otp_secret.nil?
    update!(otp_secret: User.generate_otp_secret)
  end

  # Ensure that the user is prompted for their OTP when they login
  def enable_two_factor!
    update!(otp_required_for_login: true)
  end

  # Disable the use of OTP-based two-factor.
  def disable_two_factor!
    update!(
      otp_required_for_login: false,
      otp_secret: nil,
      otp_backup_codes: nil,
    )
  end

  # URI for OTP two-factor QR code
  def two_factor_qr_code_uri
    issuer = "Atomic Jolt"
    label = "#{Rails.application.secrets.application_name} - #{email}"

    otp_provisioning_uri(label, issuer: issuer)
  end

  # Determine if backup codes have been generated
  def two_factor_backup_codes_generated?
    otp_backup_codes.present?
  end

  ####################################################
  #
  # Omniauth related methods
  #
  def self.for_auth(auth)
    Authentication.for_auth(auth)&.user
  end

  def apply_oauth(auth)
    self.attributes = User.params_for_create(auth)
    setup_authentication(auth)
  end

  def update_oauth(auth)
    setup_authentication(auth)
  end

  def self.oauth_info(auth)
    info = auth["info"] || {}
    raw_info = auth["extra"]["raw_info"] if auth["extra"].present?
    raw_info ||= {}
    [info, raw_info]
  end

  def self.oauth_name(auth)
    info, raw_info = oauth_info(auth)
    info["name"] ||
      "#{info['first_name']} #{info['last_name']}" ||
      info["nickname"] ||
      raw_info["name"] ||
      raw_info["short_name"] ||
      raw_info["login_id"]
  end

  def self.oauth_email(auth)
    info, raw_info = oauth_info(auth)
    email = info["email"] ||
      raw_info["primary_email"] ||
      raw_info["login_id"]

    # Try a basic validation on the email
    if email =~ /\A[^@]+@[^@]+\Z/
      email
    else
      # we have to make one up
      domain = UrlHelper.safe_host(info["url"])
      name = auth["uid"]
      "#{name}@#{domain}"
    end
  end

  def self.oauth_lti_user_id(auth)
    info, raw_info = oauth_info(auth)
    raw_info["lti_user_id"]
  end

  def self.params_for_create(auth)
    {
      email: oauth_email(auth),
      name: oauth_name(auth),
    }
  end

  def setup_authentication(auth)
    attributes = Authentication.authentication_attrs_from_auth(auth)
    if persisted? &&
        authentication = authentications.find_by(
          provider: attributes[:provider],
          provider_url: attributes[:provider_url],
        )
      authentication.update!(attributes)
    else
      authentications.build(attributes)
    end
  end

  def associate_account(auth)
    self.name ||= User.oauth_name(auth)
    save!
    setup_authentication(auth)
  end

  ####################################################
  #
  # Role related methods
  #
  def set_default_role
    self.role ||= :user
  end

  def context_roles(context_id = nil)
    roles.where(permissions: { context_id: context_id }).distinct
  end

  def nil_or_context_roles(context_id = nil)
    # This is sometimes called with different context ids for the same user
    # object, so memoize them all
    @context_roles ||= Hash.new do |h, key|
      h[key] = roles.where(permissions: { context_id: [key, nil] }).distinct
    end
    @context_roles[context_id]
  end

  def role?(name, context_id = nil)
    has_role?(context_id, name)
  end

  def has_role?(context_id, *test_names)
    test_names = [test_names] unless test_names.is_a?(Array)
    test_names = test_names.map(&:downcase).flatten

    role_names = nil_or_context_roles(context_id).map(&:name).map(&:downcase)

    return false if role_names.blank?

    !(role_names & test_names).empty?
  end

  def any_role?(*test_names)
    has_role?(nil, *test_names)
  end

  # Add the user to a new role
  def add_to_role(name, context_id = nil)
    role = Role.where(name: name).first_or_create
    # Make sure that the user can only be put into a role once
    if context_roles(context_id).exclude?(role)
      Permission.create(user: self, role: role, context_id: context_id)
    end
  end

  def admin?
    role?("administrator")
  end

  def lti_instructor?(context_id)
    has_role?(
      context_id,
      Lti::Roles::INSTRUCTOR,
      *LtiAdvantage::Definitions::INSTRUCTOR_ROLES,
    )
  end

  def lti_ta?(context_id)
    has_role?(
      context_id,
      Lti::Roles::TA,
    )
  end

  def lti_admin?(context_id)
    has_role?(
      context_id,
      *Lti::Roles::ADMIN_ROLES,
      *LtiAdvantage::Definitions::ADMINISTRATOR_ROLES,
    )
  end

  def lti_content_developer?(context_id)
    has_role?(
      context_id,
      Lti::Roles::CONTENT_DEVELOPER,
      LtiAdvantage::Definitions::CONTENT_DEVELOPER_CONTEXT_ROLE,
    )
  end

  def lti_admin_or_instructor?(context_id)
    lti_instructor?(context_id) || lti_admin?(context_id)
  end

  def can_author?(context_id, application_instance)
    return true if lti_admin_or_instructor?(context_id)
    roles = application_instance.get_config(:author_roles)
    has_role?(
      context_id,
      *roles,
    )
  end

  def student_in_course?(context_id = nil)
    has_role?(
      context_id,
      Lti::Roles::LEARNER,
      *LtiAdvantage::Definitions::STUDENT_ROLES,
    )
  end

  def can_edit?(user)
    return false if user.nil?
    id == user.id || user.admin?
  end

  def self.convert_name_to_initials(sortable_name)
    parts = sortable_name.split(",")
    "#{parts[1].strip[0]}#{parts[0].strip[0]}".upcase
  rescue
    return "?" unless sortable_name && !sortable_name.empty?
    return sortable_name[0..1].upcase if sortable_name.length > 1
    sortable_name[0]
  end

end
