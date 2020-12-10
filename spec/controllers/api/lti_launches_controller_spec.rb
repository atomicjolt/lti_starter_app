require "rails_helper"

RSpec.describe Api::LtiLaunchesController, type: :controller do
  before do
    setup_lti_users
    setup_application_instance

    @content_item = {
      "@context" => "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
      "@graph" => [{
        "@type" => "ContentItem",
        "mediaType" => "text/html",
        "text" => "<div>test</div>",
        "placementAdvice" => {
          "presentationDocumentTarget" => "embed",
        },
      }],
    }
  end

  context "no jwt" do
    describe "POST create" do
      it "returns unauthorized" do
        post :create, format: :json
        expect(response).to have_http_status(401)
      end
    end
  end

  context "as user" do
    before do
      request.headers["Authorization"] = @student_token
    end

    describe "POST create" do
      it "creates a new lti launch and return the result" do
        post :create, params: {
          lti_launch: FactoryBot.attributes_for(:lti_launch),
          content_item: @content_item,
          content_item_return_url: "http://www.example.com/return",
        }, format: :json
        expect(response).to have_http_status(200)
      end

      it "sets the lti launch with the correct config" do
        post :create, params: {
          lti_launch: { config: { test: "value" } },
          content_item: @content_item,
          content_item_return_url: "http://www.example.com/return",
        }, format: :json
        json = JSON.parse(response.body)
        config = json["lti_launch"]["config"]
        expect(config["test"]).to eq("value")
      end
    end
  end
end
