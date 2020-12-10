require "rails_helper"
require "rack/mock"

describe OauthStateMiddleware do
  context "using site id from site" do
    before do
      @site = FactoryBot.create(:site)
      @app_callback_url = "http://atomic.example.com"
      @payload = {
        site_id: @site.id,
        app_callback_url: @app_callback_url,
      }
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
        expect(query["signature"].present?).to be true
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
        expect(@env["canvas.url"]).to eq(@site.url)
        request = Rack::Request.new(@env)
        expect(request.params["site_id"]).to eq(@site.id)
      end

      it "Deletes the Oauth State" do
        expect { @middleware.call(@env) }.to change { OauthState.count }.by(-1)
      end
    end

  end

  context "using oauth_consumer_key from application instance" do
    before do
      setup_application_instance
      @app_callback_url = "http://atomic.example.com"
      @payload = {
        oauth_consumer_key: @application_instance.lti_key,
        app_callback_url: @app_callback_url,
      }
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
        expect(query["signature"].present?).to be true
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
        return_url << @middleware.signed_query_string(query, @application_instance.site.secret)
        @env = Rack::MockRequest.env_for(return_url)
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

  end
end
