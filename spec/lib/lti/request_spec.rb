require "rails_helper"

RSpec.describe Lti::Request do
  before do
    @domain = "www.example.com"
    @launch_url = "https://#{@domain}/lti_launches"
    @import_url = "https://#{@domain}/api/ims_imports"
    @export_url = "https://#{@domain}/api/ims_exports"
    @basic_config = {
      secure_launch_url: @launch_url,
      launch_url: @launch_url,
      export_url: @export_url,
      import_url: @import_url,
      title: "Atomic LTI test",
      description: "This is the test application for the Atomic LTI engine",
      icon: "oauth_icon.png",
      domain: @domain,
    }
    @icon_url = "https://#{@basic_config[:domain]}/#{@basic_config[:icon]}"
  end

  describe "oauth_consumer_key" do
    it "returns the lti key from the params" do
      oauth_consumer_key = "atestkey"
      params = {
        "oauth_consumer_key" => oauth_consumer_key,
      }
      request = double("request")
      allow(request).to receive(:params) { params }
      expect(Lti::Request.oauth_consumer_key(request)).to eq oauth_consumer_key
    end

    it "returns the lti key from the jwt" do
      oauth_consumer_key = "atestkey"
      token = AuthToken.issue_token({ kid: oauth_consumer_key })
      params = {}
      request = double("request")
      allow(request).to receive(:params) { params }
      allow(request).to receive(:get_header).with("HTTP_AUTHORIZATION") { "Bearer #{token}" }
      expect(Lti::Request.oauth_consumer_key(request)).to eq oauth_consumer_key
    end
  end
end
