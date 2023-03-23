require "rails_helper"
require "rack/mock"

describe OauthStateMiddleware do
  context "using site id from site" do
    before do
      @site = FactoryBot.create(:site)
      @user = FactoryBot.create(:user)
      @site = FactoryBot.create(:site)
      @app_callback_url = "http://atomic.example.com"
      @payload = {
        user_id: @user.id,
        site_id: @site.id,
        application_instance_id: nil,
        app_callback_url: @app_callback_url,
        oauth_complete_url: nil,
        canvas_url: "https://mysite.canvas.com",
        request_env: {
          "oauth_restored_env": "env_abc",
        },
        request_params: {
          "oauth_restored_param": "param_abc",
        },
      }.deep_stringify_keys
      @oauth_state = FactoryBot.create(:oauth_state, payload: @payload.to_json)
      @state = @oauth_state.state
      @code = "1234"
      @nonce = SecureRandom.hex(64)
      app = lambda { |env| }
      @middleware = OauthStateMiddleware.new(app)
    end

    context "Initial request after OAuth response" do
      before do
        @env = Rack::MockRequest.env_for("http://example.com?state=#{@state}&code=#{@code}")
      end

      it "doesn't delete the oauth state" do
        @middleware.call(@env)
        oauth_state = OauthState.find(@oauth_state.id)
        expect(oauth_state).to eq(@oauth_state)
      end

      it "signs the redirect" do
        response = @middleware.call(@env)
        location = response[1]["Location"]
        query = Rack::Utils.parse_nested_query(location)
        expect(query["oauth_redirect_signature"].present?).to be true
      end

      it "redirects back to the original app url" do
        response = @middleware.call(@env)
        expect(response[0]).to be(302)
        expect(response[1]["Location"].starts_with?(@app_callback_url)).to be true
      end
    end

    context "Redirect to original url" do
      before do
        query = {
          code: @code,
          state: @state,
          nonce: @nonce,
        }.to_query
        return_url = @app_callback_url
        return_url << "?"
        return_url << @middleware.signed_query_string(query, @site.secret)
        @env = Rack::MockRequest.env_for(return_url)
      end
      it "Restores env based on existing oauth_state" do
        @middleware.call(@env)
        expect(@env["canvas.url"]).to eq("https://mysite.canvas.com")
        expect(@env["oauth_state"]).to include(@payload.except("app_callback_url"))
      end

      it "Restores request env based on oauth_state" do
        @middleware.call(@env)
        expect(@env["oauth_restored_env"]).to eq("env_abc")
      end

      it "Restores request params based on oauth_state" do
        @middleware.call(@env)
        request = Rack::Request.new(@env)
        expect(request.params["oauth_restored_param"]).to eq("param_abc")
      end

      it "Sets the oauth_code in the request env" do
        @middleware.call(@env)
        expect(@env["oauth_code"]).to eq(@code)
      end

      it "Deletes the Oauth State" do
        expect { @middleware.call(@env) }.to change { OauthState.count }.by(-1)
      end

      it "Deletes the Oauth State" do
        expect { @middleware.call(@env) }.to change { OauthState.count }.by(-1)
      end

      it "Rejects an expired state" do
        oauth_state = OauthState.find(@oauth_state.id)
        oauth_state.update(created_at: 24.hours.ago)
        expect { @middleware.call(@env) }.to raise_exception(OauthStateMiddlewareException, /expired/)
      end

      it "Rejects a bad signature" do
        request = Rack::Request.new(@env)
        request.update_param("oauth_redirect_signature", "invalidsig")
        expect { @middleware.call(@env) }.to raise_exception(OauthStateMiddlewareException, /signatures do not match/)
      end

      it "Rejects a missing oauth state" do
        oauth_state = OauthState.find(@oauth_state.id)
        oauth_state.destroy
        expect { @middleware.call(@env) }.to raise_exception(OauthStateMiddlewareException, /Invalid state/)
      end

      it "Doesn't allow a repeat launch" do
        @middleware.call(@env)
        expect { @middleware.call(@env) }.to raise_exception(OauthStateMiddlewareException, /Invalid state/)
      end
    end
  end
end
