require "rails_helper"

RSpec.describe Api::LtiContentItemSelectionController, type: :controller do
  before do
    @application = FactoryGirl.create(
      :application,
      canvas_api_permissions: "LIST_ACCOUNTS,LIST_YOUR_COURSES,CREATE_NEW_SUB_ACCOUNT,UPDATE_ACCOUNT",
    )
    @application_instance = FactoryGirl.create(:application_instance, application: @application)
    allow(controller).to receive(:current_application_instance).and_return(@application_instance)

    @user = FactoryGirl.create(:user)
    @user.confirm
    @user_token = AuthToken.issue_token({ user_id: @user.id })
    @content_item_return_url = "http://www.example.com/return_to_me"
    @content_item_url = "http://www.example.com/lti_launch"

    @html = "<div>hi</div>"
    @html_params = {
      content_item_return_url: @content_item_return_url,
      content_item: {
        "@context" => "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
        "@graph" => [{
          "@type" => "ContentItem",
          "mediaType" => "text/html",
          "text" => @html,
          "placementAdvice" => {
            "presentationDocumentTarget" => "embed",
          },
        }],
      }.to_json,
    }

    @iframe_params = {
      content_item_return_url: @content_item_return_url,
      content_item: {
        "@context" => "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
        "@graph" => [{
          "@type" => "ContentItem",
          "mediaType" => "text/html",
          "text" => "<iframe style=\"width: 100%; height: 500px;\" src=\"#{@content_item_url}\"></iframe>",
          "placementAdvice" => {
            "presentationDocumentTarget" => "embed",
          },
        }],
      }.to_json,
    }

    @name = "Example"
    @lti_link_params = {
      content_item_return_url: @content_item_return_url,
      content_item: {
        "@context" => "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
        "@graph" => [
          {
            "@type": "LtiLinkItem",
            mediaType: "application/vnd.ims.lti.v1.ltilink",
            url: @content_item_url,
            title: @name,
          },
          {
            "@type": "LtiLinkItem",
            mediaType: "application/vnd.ims.lti.v1.ltilink",
            url: @content_item_url,
            title: @name,
            text: @name,
            lineItem: {
              "@type": "LineItem",
              label: @name,
              reportingMethod: "res:totalScore",
              maximumScore: 10,
              scoreConstraints: {
                "@type": "NumericLimits",
                normalMaximum: 10,
                totalMaximum: 10,
              },
            },
          },
        ],
      }.to_json,
    }
  end

  context "without jwt token" do
    it "should not be authorized" do
      post :create, params: @html_params, format: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with jwt token" do
    describe "GET index" do
      it "gets html launch params" do
        request.headers["Authorization"] = @user_token
        post :create, params: @html_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["content_items"]).to eq("{\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\",\"@graph\":[{\"@type\":\"ContentItem\",\"mediaType\":\"text/html\",\"text\":\"\\u003cdiv\\u003ehi\\u003c/div\\u003e\",\"placementAdvice\":{\"presentationDocumentTarget\":\"embed\"}}]}")
        expect(result["lti_message_type"]).to eq("ContentItemSelection")
        expect(result["oauth_consumer_key"]).to eq(@application_instance.lti_key)
      end
      it "gets iframe launch params" do
        request.headers["Authorization"] = @user_token
        post :create, params: @iframe_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["content_items"]).to eq("{\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\",\"@graph\":[{\"@type\":\"ContentItem\",\"mediaType\":\"text/html\",\"text\":\"\\u003ciframe style=\\\"width: 100%; height: 500px;\\\" src=\\\"http://www.example.com/lti_launch\\\"\\u003e\\u003c/iframe\\u003e\",\"placementAdvice\":{\"presentationDocumentTarget\":\"embed\"}}]}")
        expect(result["lti_message_type"]).to eq("ContentItemSelection")
        expect(result["oauth_consumer_key"]).to eq(@application_instance.lti_key)
      end
      it "gets lti_link launch params" do
        request.headers["Authorization"] = @user_token
        post :create, params: @lti_link_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["content_items"]).to eq("{\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\",\"@graph\":[{\"@type\":\"LtiLinkItem\",\"mediaType\":\"application/vnd.ims.lti.v1.ltilink\",\"url\":\"http://www.example.com/lti_launch\",\"title\":\"Example\"},{\"@type\":\"LtiLinkItem\",\"mediaType\":\"application/vnd.ims.lti.v1.ltilink\",\"url\":\"http://www.example.com/lti_launch\",\"title\":\"Example\",\"text\":\"Example\",\"lineItem\":{\"@type\":\"LineItem\",\"label\":\"Example\",\"reportingMethod\":\"res:totalScore\",\"maximumScore\":10,\"scoreConstraints\":{\"@type\":\"NumericLimits\",\"normalMaximum\":10,\"totalMaximum\":10}}}]}")
        expect(result["lti_message_type"]).to eq("ContentItemSelection")
        expect(result["oauth_consumer_key"]).to eq(@application_instance.lti_key)
      end
    end
  end

  describe "includes JwtToken" do
    it { expect(Api::LtiContentItemSelectionController.ancestors.include?(Concerns::JwtToken)).to eq(true) }
  end
end
