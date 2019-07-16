class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport
  include Concerns::OpenIdConnectSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti, except: [:init, :launch]

  def index
    if current_application_instance.disabled_at
      render file: File.join(Rails.root, "public", "disabled.html")
    end

    # Examples demonstrating LTI Advantage services
    names_and_roles_example
    if line_item = line_item_example
      scores_example(line_item, @names_and_roles)
      results_example(line_item)
    end

    setup_lti_response
  end

  def show
    @lti_launch = LtiLaunch.find_by(token: params[:id], context_id: params[:context_id])
    setup_lti_response
    render :index
  end

  def launch
    @launch_params = Lti::Launch.params(
      current_application_instance.lti_key,
      current_application_instance.lti_secret,
      {
        "launch_url" => lti_launches_url,
        "roles" => "Learner",
      },
    )
  end

  # Support Open ID connect flow for LTI 1.3
  def init
    nonce = SecureRandom.hex(10)
    state = AuthToken.issue_token({
      state_nonce: nonce,
      params: params.as_json
    })
    url = build_response(state, params, nonce)
    request.cookies[:state] = state
    respond_to do |format|
      format.html { redirect_to url }
    end
  end

  private

  def setup_lti_response
    begin
      @canvas_api = canvas_api
      @canvas_auth_required = @canvas_api.blank?
    rescue Exceptions::CanvasApiTokenRequired
      @canvas_auth_required = true
    end
    set_lti_launch_values
  end

  # This method demonstrates create, delete and update of line items using
  # LtiAdvantage::Services::LineItems
  def line_item_example
    line_item = LtiAdvantage::Services::LineItems.new(current_application_instance, @lti_token)
    line_items = line_item.list
    @line_items = JSON.parse(line_items.body)

    resource_id = 1
    tag = "lti-advantage"
    external_tool_url = "https://#{current_application_instance.domain}/lti_launches"

    delete_items = false

    if ["200", "201"].include?(line_items.response.code)
      if delete_items
        # Delete Line items
        @line_items.each do |li|
          line_item.delete(li["id"])
        end
        found = false
      else
        found = @line_items.find{ |li| li["tag"] == tag }
      end

      line_item_attrs = line_item.generate(
        label: "LTI Advantage test item #{Time.now.utc}",
        max_score: 10,
        resource_id: resource_id,
        tag: tag,
        start_date_time: Time.now.utc - 1.day,
        end_date_time: Time.now.utc + 45.days,
        external_tool_url: external_tool_url,
      )

      if found
        result = line_item.update(found["id"], line_item_attrs)
      else
        result = line_item.create(line_item_attrs)
      end
      JSON.parse(result.body)
    else
      # There was an error and the line items API isn't available.
      # For example the course might be closed. These errors will be
      # rendered on the client
    end
  end

  # This example demonstrates writing scores back to the platform using the
  # LtiAdvantage::Services::Score class
  def scores_example(line_item, names_and_roles)
    return unless names_and_roles.present?
    score_service = LtiAdvantage::Services::Score.new(current_application_instance, @lti_token)
    score_service.id = line_item["id"]
    names_and_roles["members"].map do |name_role|
      in_role = (name_role["roles"] & [LtiAdvantage::Definitions::STUDENT_SCOPE, LtiAdvantage::Definitions::LEARNER_SCOPE]).length > 0
      if in_role && name_role["status"] == "Active"
        score = score_service.generate(
          user_id: name_role["user_id"],
          score: 10,
          max_score: line_item["scoreMaximum"],
          comment: "Great job",
          activity_progress: "Completed",
          grading_progress: "FullyGraded",
        )
        result = score_service.send(score)
        JSON.parse(result.body)
      end
    end
  end

  # This example demonstrates reading scores from the platform using the
  # LtiAdvantage::Services::Results class
  def results_example(line_item)
    results_service = LtiAdvantage::Services::Results.new(current_application_instance, @lti_token)
    result = results_service.list(line_item["id"])
    @line_item_results = JSON.parse(result)
  end

  # This example demonstrates reading names and roles from the platform using the
  # LtiAdvantage::Services::NamesAndRoles class
  def names_and_roles_example
    names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(current_application_instance, @lti_token)
    @names_and_roles = names_and_roles_service.list if names_and_roles_service.valid?
  end
end

