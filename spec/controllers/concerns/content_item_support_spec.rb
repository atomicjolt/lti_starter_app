require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    @app = FactoryGirl.create(:application_instance)
    allow(controller).to receive(:current_application_instance).and_return(@app)
    allow(Application).to receive(:find_by).with(:lti_key).and_return(@app)

    @content_item_return_url = "http://www.example.com/return_to_me"

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
  end

  controller do
    include Concerns::ContentItemSupport

    skip_before_action :verify_authenticity_token

    def create
      render json: generate_content_item_data("fake_id", params[:content_item_return_url], params[:content_item])
    end
  end

  describe "Content Item" do
    it "Returns a content item response" do
      post :create, params: @html_params, format: :json
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["oauth_consumer_key"]).to be_present
      expect(json["oauth_signature_method"]).to eq("HMAC-SHA1")
      expect(json["oauth_timestamp"]).to be_present
      expect(json["oauth_nonce"]).to be_present
      expect(json["oauth_version"]).to eq("1.0")
      expect(json["content_items"]).to eq("{\"@graph\":[{\"text\":\"\\u003cdiv\\u003ehi\\u003c/div\\u003e\",\"placementAdvice\":{\"presentationDocumentTarget\":\"embed\"},\"mediaType\":\"text/html\",\"@type\":\"ContentItem\"}],\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\"}")
      expect(json["lti_message_type"]).to eq("ContentItemSelection")
      expect(json["lti_version"]).to eq("LTI-1p0")
      expect(json["oauth_signature"]).to be_present
    end
  end
end
