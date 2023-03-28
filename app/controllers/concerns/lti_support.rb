require "jwt"

module LtiSupport
  extend ActiveSupport::Concern

  included do
    helper_method :lti_provider, :lti_advantage?, :lti, :lti_launch?
  end

  def lti
    @_lti
  end

  protected

  def do_lti
    @_lti = if request.env["atomic.validated.id_token"].present?
              LtiAdvantage::Request.new(request, current_application_instance)
            else
              Lti::Request.new(request, current_application_instance)
            end
    user = user_from_lti
    user.confirm unless user.confirmed?
    sign_in(user, event: :authentication, store: false)
  end

  def lti_advantage?
    lti&.lti_advantage?
  end

  def lti_launch?
    lti.present?
  end

  def lti_provider
    lti&.lti_provider
  end

  def user_from_lti
    attempts = 0
    begin
      attempts += 1
      lti.user_from_lti
    rescue ActiveRecord::RecordNotUnique => e
      # Retry once in case we created the same user twice.  This happens when multiple
      # launches appear on the same page for a new user.
      raise e if attempts > 1

      # Give the other process a chance to fully create the user. We should find a better solution
      sleep(3)
      retry
    end
  end

  def lti_deployment
    return nil unless lti_advantage?

    @lti_deployment ||= LtiDeployment.joins(:lti_install).find_by(
      deployment_id: lti.deployment_id,
      application_instance: current_application_instance,
      lti_installs: { iss: lti.iss, client_id: lti.client_id },
    )
  end
end
