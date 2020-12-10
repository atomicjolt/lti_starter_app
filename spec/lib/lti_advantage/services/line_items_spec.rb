require "rails_helper"

RSpec.describe LtiAdvantage::Services::LineItems do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
    @lti_token = LtiAdvantage::Authorization.validate_token(@application_instance, @params["id_token"])
    @line_item = LtiAdvantage::Services::LineItems.new(@application_instance, @lti_token)
    @id = "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/31"
  end

  describe "list" do
    it "lists users in the course and their roles" do
      line_items = @line_item.list
      parsed = JSON.parse(line_items.body)
      expect(parsed.empty?).to be false
    end
  end

  describe "show" do
    it "lists users in the course and their roles" do
      result = @line_item.show(@id)
      parsed = JSON.parse(result.body)
      expect(parsed["id"]).to eq "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/31"
    end
  end

  describe "create" do
    it "lists users in the course and their roles" do
      line_item_attrs = @line_item.generate(
        label: "LTI Advantage test item #{Time.now.utc}",
        max_score: 10,
        resource_id: 1,
        tag: "test",
        start_date_time: Time.now.utc - 1.day,
        end_date_time: Time.now.utc + 45.days,
        external_tool_url: "https://www.example.com/url",
      )
      result = @line_item.create(line_item_attrs)
      parsed = JSON.parse(result.body)
      expect(parsed["id"]).to eq "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/29"
    end
  end

  describe "update" do
    it "lists users in the course and their roles" do
      line_item_attrs = {
        label: "LTI Advantage test item #{Time.now.utc}",
        scoreMaximum: 10,
        resourceId: 1,
        tag: "test",
      }
      result = @line_item.update(@id, line_item_attrs)
      parsed = JSON.parse(result.body)
      expect(parsed["id"]).to eq "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/31"
    end
  end

  describe "delete" do
    it "lists users in the course and their roles" do
      result = @line_item.delete(@id)
      expect(result.response.code).to eq "200"
    end
  end
end
