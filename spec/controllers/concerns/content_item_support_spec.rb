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
      #expect(response.body).to include("User:")
      # {"oauth_consumer_key"=>"lti-key-1",
      #  "oauth_signature_method"=>"HMAC-SHA1",
      #  "oauth_timestamp"=>"1498016059",
      #  "oauth_nonce"=>"6H2Zecde2NP05Mq6hoFL71KHPkrBwF5hIXaLcC0Gh0",
      #  "oauth_version"=>"1.0",
      #  "content_items"=>"{\"@context\":\"http://purl.imsglobal.org/ctx/lti/v1/ContentItem\",\"@graph\":[{\"@type\":\"ContentItem\",\"mediaType\":\"text/html\",\"text\":\"\\u003cdiv\\u003ehi\\u003c/div\\u003e\",\"placementAdvice\":{\"presentationDocumentTarget\":\"embed\"}}]}",
      #  "lti_message_type"=>"ContentItemSelection",
      #  "lti_version"=>"LTI-1p0",
      #  "resource_link_id"=>"fake_id",
      #  "oauth_signature"=>"L1vjCDNAj94sSRkO0hClpQjPE8w="}
    end
  end
end
