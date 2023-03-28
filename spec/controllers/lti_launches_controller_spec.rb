require "rails_helper"

describe LtiLaunchesController, type: :controller do
  before do
    setup_application_and_instance
    request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
  end

  describe "index" do
    context "with an lti 1.1 launch" do
      before do
        base_params = {
          "launch_url" => lti_launches_url,
          "roles" => "urn:lti:role:ims\/lis\/Instructor",
          "resource_link_id" => "test",
          "custom_canvas_course_id" => "1",
          "custom_canvas_api_domain" => "atomicjolt.instructure.com",
        }

        @learner_lti_params = lti_params(
          @application_instance.lti_key,
          @application_instance.lti_secret,
          base_params.merge({ "roles" => "urn:lti:role:ims\/lis\/Learner" }),
        )

        @instructor_lti_params = lti_params(
          @application_instance.lti_key,
          @application_instance.lti_secret,
          base_params,
        )
      end

      it "sets up the user and logs them in" do
        post :index, params: @instructor_lti_params

        expect(response).to have_http_status(200)
      end

      it "is disabled if application instance is disabled" do
        @application_instance.disabled_at = Time.now
        @application_instance.save
        post :index, params: @learner_lti_params
        expect(response).to redirect_to("/disabled.html")
      end

      context "when launching as an instructor" do
        it "sets the app name" do
          post :index, params: @instructor_lti_params
          expect(controller.send(:app_name)).to eq("admin")
        end

        it "sets the canvas url" do
          controller.instance_variable_set(:@canvas_url, "https://other.com")
          post :index, params: @instructor_lti_params
          expect(controller.instance_variable_get(:@canvas_url)).to eq("https://atomicjolt.instructure.com")
        end

        it "returns 200" do
          post :index, params: @instructor_lti_params
          expect(response).to have_http_status(200)
        end
      end

      context "when launching as a student" do
        it "returns 200" do
          post :index, params: @learner_lti_params
          expect(response).to have_http_status(200)
        end
      end

      it "sets email correctly" do
        post :index, params: @instructor_lti_params
        expect(controller.helpers.lti_launch_email).to eq "atomicjolt@example.com"
      end
    end

    context "with an lti advantage launch" do
      before do
        allow(controller).to receive(:current_application).and_return(@application)
      end
      context "as an instructor" do
        before do
          setup_canvas_lti_advantage(application_instance: @application_instance)
          setup_atomic_lti_values(application_instance: @application_instance)
        end

        it "sets up the user and logs them in" do
          post :index, params: @params
          expect(response).to have_http_status(200)
        end

        it "is disabled if application instance is disabled" do
          @application_instance.disabled_at = Time.now
          @application_instance.save
          post :index, params: @params
          expect(response).to redirect_to("/disabled.html")
        end

        it "sets the app name" do
          post :index, params: @params
          expect(controller.send(:app_name)).to eq("admin")
        end

        it "returns 200" do
          post :index, params: @params
          expect(response).to have_http_status(200)
        end

        it "checks canvas auth when it exists" do
          post :index, params: @params
          expect(controller.instance_variable_get(:@canvas_auth_required)).to eq(false)
        end

        it "checks canvas auth when it doesn't exist" do
          @application_instance.update(canvas_token: nil)
          post :index, params: @params
          expect(controller.instance_variable_get(:@canvas_auth_required)).to eq(true)
        end

        it "sets email correctly" do
          post :index, params: @params
          expect(controller.helpers.lti_launch_email).to eq "atomicjolt@example.com"
        end
      end

      context "as a student" do
        before do
          roles = ["http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student",
                   "http://purl.imsglobal.org/vocab/lis/v2/system/person#User"]
          setup_canvas_lti_advantage(application_instance: @application_instance, roles: roles)
          setup_atomic_lti_values(application_instance: @application_instance)
        end

        it "returns 200" do
          post :index, params: @params
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe "show" do
    before do
      config = {}
      @context_id = SecureRandom.hex(15)
      @lti_launch = FactoryBot.create(:lti_launch, config: config, context_id: @context_id)
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end
    context "with an lti advantage launch" do
      before do
        allow(controller).to receive(:current_application).and_return(@application)
      end

      context "as an instructor" do
        before do
          setup_canvas_lti_advantage(
            application_instance: @application_instance,
            launch_token: @lti_launch.token,
            context_id: @context_id,
          )
          setup_atomic_lti_values(application_instance: @application_instance)
          @params[:id] = @lti_launch.token
        end

        it "does an lti advantage launch" do
          post :show, params: @params
          expect(response).to have_http_status(200)
        end

        it "renders the index" do
          post :show, params: @params
          expect(response).to render_template(:index)
        end

        it "sets the app name" do
          post :show, params: @params
          expect(controller.send(:app_name)).to eq("admin")
        end

        it "sets the canvas url" do
          controller.instance_variable_set(:@canvas_url, "https://other.com")
          post :show, params: @params
          expect(controller.instance_variable_get(:@canvas_url)).to eq("https://atomicjolt.instructure.com")
        end
      end

      context "as a student" do
        before do
          roles = ["http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student",
                   "http://purl.imsglobal.org/vocab/lis/v2/system/person#User"]
          setup_canvas_lti_advantage(
            application_instance: @application_instance,
            launch_token: @lti_launch.token,
            context_id: @context_id,
            roles: roles,
          )
          setup_atomic_lti_values(application_instance: @application_instance)
          @params[:id] = @lti_launch.token
        end

        it "does an lti advantage launch" do
          post :show, params: @params
          expect(response).to have_http_status(200)
        end

        it "renders the index" do
          post :show, params: @params
          expect(response).to render_template(:index)
        end

        it "sets the app name" do
          post :show, params: @params
          expect(controller.send(:app_name)).to eq("admin")
        end
      end

      context "as an user with minimal claims" do
        before do
          target_link_uri = "https://helloworld.atomicjolt.xyz/lti_launches/#{@lti_launch.token}"
          new_payload = {
            "https://purl.imsglobal.org/spec/lti/claim/message_type": "LtiResourceLinkRequest",
            "https://purl.imsglobal.org/spec/lti/claim/version": "1.3.0",
            "aud": "1234-5678",
            "azp": "1234-5678",
            "https://purl.imsglobal.org/spec/lti/claim/deployment_id": "deploy-1234",
            "exp": 1.hours.from_now.to_i,
            "iat": Time.now.to_i,
            "iss": "https://canvas.instructure.com",
            "nonce": SecureRandom.hex(10),
            "sub": "lti-1234",
            "https://purl.imsglobal.org/spec/lti/claim/target_link_uri": target_link_uri,
            "https://purl.imsglobal.org/spec/lti/claim/roles": [],
          }

          site = Site.find_or_create_by(url: "https://atomicjolt.instructure.com")
          @application_instance.site = site
          @application_instance.save!

          @application_instance.application.lti_installs.create!(
            iss: "https://canvas.instructure.com",
            client_id: "1234-5678",
            jwks_url: AtomicLti::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL,
            token_url: AtomicLti::Definitions::CANVAS_AUTH_TOKEN_URL,
            oidc_url: AtomicLti::Definitions::CANVAS_OIDC_URL,
          )

          @lti_deployment = @application_instance.lti_deployments.create!(
            deployment_id: "deploy-1234",
            lti_install: @application_instance.application.lti_installs.last,
          )
          # jwk = @application_instance.application.current_jwk
          jwk = AtomicLti::Jwk.new
          jwk.generate_keys
          stub_canvas_jwks(jwks: [jwk])

          @lti_launch.update!(context_id: nil)

          @id_token = JWT.encode(
            new_payload,
            jwk.private_key,
            jwk.alg,
            kid: jwk.kid,
            typ: "JWT",
          )
          @lti_token = JWT.decode(@id_token, nil, false)
          nonce = SecureRandom.hex(64)
          OpenIdState.create!(nonce: nonce)
          state = AuthToken.issue_token({ nonce: nonce })
          @params = {
            "id_token" => @id_token,
            "state" => state,
            "id" => @lti_launch.token,
          }
          @request.host = "helloworld.atomicjolt.xyz"
          @request.env["HTTPS"] = "on"

          setup_atomic_lti_values(application_instance: @application_instance)
        end

        it "does an lti advantage launch" do
          post :show, params: @params
          expect(response).to have_http_status(200)
        end
      end
    end

    context "with an lti 1.1 launch" do
      context "app" do
        before do
          base_params = {
            "launch_url" => lti_launch_url(@lti_launch.token),
            "roles" => "Learner",
            "resource_link_id" => @lti_launch.token,
            "context_id" => @context_id,
            "custom_canvas_course_id" => "1",
            "resource_link_title" => "Resource title 1",
            "custom_canvas_assignment_id" => "123",
            "custom_canvas_user_id" => "canvas_1234",
            "custom_canvas_api_domain" => "atomicjolt.instructure.com",
          }

          @learner_lti_params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            base_params,
          )

          @instructor_lti_params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            base_params.merge({ "roles" => "urn:lti:role:ims\/lis\/Instructor" }),
          )
        end

        it "sets up the user, logs them and outputs the lti config to the client" do
          post :show, params: { id: @lti_launch.token }.merge(@learner_lti_params)

          expect(response).to have_http_status(200)
          expect(response.body).to include("lti_launch_config")
        end

        it "returns 401 if additional parameters are added" do
          post :show, params: { id: @lti_launch.token, custom_abc: "123" }.merge(@learner_lti_params)
          expect(response).to have_http_status(401)
        end

        it "cleans lti parameters" do
          post :show, params: { id: @lti_launch.token, submitted_access_code: "123" }.merge(@learner_lti_params)
          expect(response).to have_http_status(200)
        end

        it "is disabled if application instance is disabled" do
          @application_instance.disabled_at = Time.now
          @application_instance.save
          post :show, params: { id: @lti_launch.token }.merge(@learner_lti_params)
          expect(response).to redirect_to("/disabled.html")
        end
      end

      context "invalid token" do
        it "returns a 200" do
          bad_token = "abadtoken"
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => lti_launch_url(bad_token),
            },
          )
          post :show, params: { id: bad_token }.merge(params)
          expect(response).to have_http_status(200)
        end
      end

      context "when the LtiLaunch doesn't have a resource_link_id" do
        it "updates the LtiLaunch with the resource_link_id" do
          context_id = SecureRandom.hex
          resource_link_id = SecureRandom.hex
          lti_launch = FactoryBot.create(:lti_launch, context_id: context_id)
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => lti_launch_url(lti_launch.token),
              "context_id" => context_id,
              "resource_link_id" => resource_link_id,
            },
          )

          post :show, params: { id: lti_launch.token }.merge(params)

          expect(lti_launch.reload.resource_link_id).to eq(resource_link_id)
        end
      end
    end
  end
end
