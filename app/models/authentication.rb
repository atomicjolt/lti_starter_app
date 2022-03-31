class Authentication < ApplicationRecord

  has_secure_token :id_token

  # NOTE these columns are temporary while we migrate away from attr_encrypted to the
  # new Rails 7 encrypt
  begin
    if column_names.include? "encrypted_token"
      attr_encrypted :token, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
    end

    if column_names.include? "encrypted_token_2"
      attr_encrypted :token_2, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
    end

    if column_names.include? "token"
      encrypts :token
    end

    if column_names.include? "encrypted_secret"
      attr_encrypted :secret, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
    end

    if column_names.include? "encrypted_secret_2"
      attr_encrypted :secret_2, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
    end

    if column_names.include? "secret"
      encrypts :secret
    end

    if column_names.include? "encrypted_refresh_token"
      attr_encrypted :refresh_token, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
    end

    if column_names.include? "encrypted_refresh_token_2"
      attr_encrypted :refresh_token_2, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
    end

    if column_names.include? "refresh_token"
      encrypts :refresh_token
    end
  rescue => ex
    puts "Error setting up columns: #{ex}."
  end
  #### END


  belongs_to :user, inverse_of: :authentications
  belongs_to :application_instance, inverse_of: :authentications, required: false
  belongs_to :canvas_course, inverse_of: :authentications, required: false

  validates :provider,
            presence: true,
            uniqueness: {
              scope: %i[
                uid
                user_id
                application_instance_id
                canvas_course_id
                provider_url
              ],
            }

  def copy_to_tenant(application_instance, user)
    Apartment::Tenant.switch(application_instance.tenant) do
      authentication = user.authentications.find_or_initialize_by(
        uid: attributes["uid"],
        provider: attributes["provider"],
        provider_url: attributes["provider_url"],
      )
      authentication.update(tenant_copy_attributes)
      authentication
    end
  end

  def tenant_copy_attributes
    attributes.except(
      "id",
      "created_at",
      "updated_at",
      "user_id",
      "application_instance_id",
      "canvas_course_id",
    )
  end

  # Find an authentication using an auth object provided by omniauth
  def self.for_auth(auth)
    provider_url = UrlHelper.scheme_host_port(auth["info"]["url"])
    Authentication.find_by(
      uid: auth["uid"].to_s,
      provider: auth["provider"],
      provider_url: provider_url,
    )
  end

  # Build an authentication using an auth object provided by omniauth
  def self.authentication_attrs_from_auth(auth)
    raw_info = auth["extra"]["raw_info"] || {}
    info = auth["info"] || {}
    provider_url = UrlHelper.scheme_host_port(info["url"])
    attributes = {
      uid: auth["uid"].to_s,
      username: info["nickname"],
      provider: auth["provider"],
      provider_url: provider_url,
      lti_user_id: raw_info["lti_user_id"],
    }
    if credentials = auth["credentials"]
      attributes[:token] = credentials["token"]
      attributes[:secret] = credentials["secret"]
      attributes[:refresh_token] = credentials["refresh_token"] if credentials["refresh_token"]
    end
    attributes
  end

end
