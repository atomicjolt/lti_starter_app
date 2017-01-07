require "rails_helper"
require "rack/mock"

describe OauthStateMiddleware do
  before do
    @lti_application_instance = FactoryGirl.create(:lti_application_instance)
    @payload = {
      oauth_consumer_key: @lti_application_instance.lti_key
    }
    @oauth_state = FactoryGirl.create(:oauth_state, payload: @payload.to_json)
    @state = @oauth_state.state

    app = lambda{|env|}
    @env = Rack::MockRequest.env_for("http://example.com?state=#{@state}")
    @middleware = OauthStateMiddleware.new(app)
  end

  it "Restores env based on existing oauth_state" do
    @middleware.call(@env)
    expect(@env["canvas.url"]).to eq(@lti_application_instance.lti_consumer_uri)
    expect(@env["oauth.state"]["oauth_consumer_key"]).to eq(@lti_application_instance.lti_key)
  end

  it "Deletes the Oauth State" do
    expect{@middleware.call(@env)}.to change{OauthState.count}.by(-1)
  end
end