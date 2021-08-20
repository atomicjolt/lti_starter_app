class LtiDeploymentsController < ApplicationController
  def index; end

  def create
    application_instance = current_application_instance

    token = params[:id_token]
    decoded_token = JWT.decode(token, nil, false)
    payload = decoded_token[PAYLOAD]

    iss = payload["iss"]
    lti_install = application_instance.application.lti_installs.find_by(iss: iss)

    deployment_id = payload[LtiAdvantage::Definitions::DEPLOYMENT_ID]

    lms_url = LtiAdvantage::Definitions.lms_url(payload)
    site = Site.find_by(url: lms_url)

    if params[:make_new]
      # Create a new application instance and lti_deployment
      lti_key = "#{site.key}-#{lti_install.application.key}-#{deployment_id}"
      application_instance = lti_install.application.create_instance(site: site, lti_key: lti_key)
    end

    application_instance.lti_deployments.create!(
      lti_install: lti_install,
      deployment_id: deployment_id,
    )
  end
end
