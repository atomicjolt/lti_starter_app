require "rails_helper"
require "rack/mock"

describe OauthStateMiddleware do
  before do
    @application_instance = FactoryGirl.create(:application_instance)
    @payload = {
      oauth_consumer_key: @application_instance.lti_key,
    }
    @oauth_state = FactoryGirl.create(:oauth_state, payload: @payload.to_json)
    @state = @oauth_state.state
    @code = "1234"

    app = lambda { |env| }
    @env = Rack::MockRequest.env_for("http://example.com?state=#{@state}&code=#{@code}")
    @middleware = OauthStateMiddleware.new(app)
  end

  it "Restores env based on existing oauth_state" do
    @middleware.call(@env)
    expect(@env["canvas.url"]).to eq(@application_instance.site.url)
    request = Rack::Request.new(@env)
    expect(request.params["oauth_consumer_key"]).to eq(@application_instance.lti_key)
  end

  it "Deletes the Oauth State" do
    expect { @middleware.call(@env) }.to change { OauthState.count }.by(-1)
  end
end
