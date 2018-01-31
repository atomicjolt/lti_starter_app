require "rails_helper"

RSpec.describe Api::LtiContentItemSelectionController, type: :controller do
  before do
    setup_lti_users
    setup_application_and_instance

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
        request.headers["Authorization"] = @student_token
        post :create, params: @html_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["content_items"]).to eq("{\"@graph\":[{\"text\":\"\\u003cdiv\\u003ehi\\u003c/div\\u003e\",\"placementAdvice\":{\"presentationDocumentTarget\":\"embed\"},\"mediaType\":\"text/html\",\"@type\":\"ContentItem\"}],\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\"}")
        expect(result["lti_message_type"]).to eq("ContentItemSelection")
        expect(result["oauth_consumer_key"]).to eq(@application_instance.lti_key)
      end
      it "gets iframe launch params" do
        request.headers["Authorization"] = @student_token
        post :create, params: @iframe_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["content_items"]).to eq("{\"@graph\":[{\"text\":\"\\u003ciframe style=\\\"width: 100%; height: 500px;\\\" src=\\\"http://www.example.com/lti_launch\\\"\\u003e\\u003c/iframe\\u003e\",\"placementAdvice\":{\"presentationDocumentTarget\":\"embed\"},\"mediaType\":\"text/html\",\"@type\":\"ContentItem\"}],\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\"}")
        expect(result["lti_message_type"]).to eq("ContentItemSelection")
        expect(result["oauth_consumer_key"]).to eq(@application_instance.lti_key)
      end
      it "gets lti_link launch params" do
        request.headers["Authorization"] = @student_token
        post :create, params: @lti_link_params, format: :json
        expect(response).to have_http_status(:success)
        result = JSON.parse(response.body)
        expect(result["content_items"]).to eq("{\"@graph\":[{\"title\":\"Example\",\"url\":\"http://www.example.com/lti_launch\",\"mediaType\":\"application/vnd.ims.lti.v1.ltilink\",\"@type\":\"LtiLinkItem\"},{\"lineItem\":{\"@type\":\"LineItem\",\"label\":\"Example\",\"reportingMethod\":\"res:totalScore\",\"maximumScore\":10,\"scoreConstraints\":{\"@type\":\"NumericLimits\",\"normalMaximum\":10,\"totalMaximum\":10}},\"text\":\"Example\",\"title\":\"Example\",\"url\":\"http://www.example.com/lti_launch\",\"mediaType\":\"application/vnd.ims.lti.v1.ltilink\",\"@type\":\"LtiLinkItem\"}],\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\"}")
        expect(result["lti_message_type"]).to eq("ContentItemSelection")
        expect(result["oauth_consumer_key"]).to eq(@application_instance.lti_key)
      end
    end
  end

  describe "includes JwtToken" do
    it { expect(Api::LtiContentItemSelectionController.ancestors.include?(Concerns::JwtToken)).to eq(true) }
  end
end
