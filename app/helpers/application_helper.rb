module ApplicationHelper

  def application_base_url
    File.join(request.base_url, "/")
  end

  def admin_panel_jwt_token(
    user: current_user,
    application_identifier: URI.parse(installed_url)&.host
  )
    payload = {
      user_id: user.id,
      application_identifier: application_identifier,
      # Hard coding root account_id 1 until catalyst is updated with admin_panel queries.
      analytics_requests_permissions: { account_ids: [1] },
      admin_panel: current_application_instance.lti_key == Application::ADMIN,
    }

    AuthToken.issue_token(
      payload,
      24.hours.from_now,
      Rails.application.secrets.catalyst_shared_token,
      Rails.application.secrets.catalyst_shared_id,
    )
  end

end
