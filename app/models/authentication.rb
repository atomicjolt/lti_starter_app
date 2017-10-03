class Authentication < ApplicationRecord

  has_secure_token :id_token

  attr_encrypted :token, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
  attr_encrypted :secret, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
  attr_encrypted :refresh_token, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt

  belongs_to :user, inverse_of: :authentications
  belongs_to :application_instance, inverse_of: :authentications
  belongs_to :canvas_course, inverse_of: :authentications

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

  def copy_to_tenant(application_instance, model = nil)
    Apartment::Tenant.switch(application_instance.tenant) do
      model = application_instance if model.nil?
      auth_dup = model.authentications.find_or_initialize_by(
        provider_url: UrlHelper.scheme_host_port(application_instance.site.url),
      )
      auth_dup.update(copy_attributes)
    end
  end

  def copy_attributes
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
      json_response: auth.to_json,
    }
    if credentials = auth["credentials"]
      attributes[:token] = credentials["token"]
      attributes[:secret] = credentials["secret"]
      attributes[:refresh_token] = credentials["refresh_token"] if credentials["refresh_token"]
    end
    attributes
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
    info = auth["info"] || {}
    provider_url = UrlHelper.scheme_host_port(info["url"])
    attributes = {
      uid: auth["uid"].to_s,
      username: info["nickname"],
      provider: auth["provider"],
      provider_url: provider_url,
      json_response: auth.to_json,
    }
    if credentials = auth["credentials"]
      attributes[:token] = credentials["token"]
      attributes[:secret] = credentials["secret"]
      attributes[:refresh_token] = credentials["refresh_token"] if credentials["refresh_token"]
    end
    attributes
  end

end
