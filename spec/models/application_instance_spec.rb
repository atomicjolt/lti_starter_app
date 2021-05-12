require "rails_helper"
require "nokogiri"

RSpec.describe ApplicationInstance, type: :model do
  describe "create application" do
    before :each do
      @site = create(:site)
      @name = "An Example application"
      @key = "example"
      @application = create(:application, name: @name, key: @key)
    end

    it "uses the provided lti key" do
      lti_key = "atomic-key"
      @application_instance = create(:application_instance, lti_key: lti_key, site: @site, application: @application)
      expect(@application_instance.key).to eq(lti_key)
      expect(@application_instance.lti_key).to eq(lti_key)
      domain = "#{@application.key}.#{Rails.application.secrets.application_root_domain}"
      expect(@application_instance.domain).to eq(domain)
    end

    it "sets a default lti key" do
      @application_instance = create(:application_instance, lti_key: nil, site: @site, application: @application)
      expect(@application_instance.lti_key).to eq(@application_instance.key)
    end

    it "generates a key based on the site and application" do
      @application_instance = create(:application_instance, lti_key: nil, site: @site, application: @application)
      expect(@application_instance.key).to eq("#{@site.key}-#{@application.key}")
    end

    it "sets a default domain" do
      @application_instance = create(
        :application_instance,
        lti_key: nil,
        domain: nil,
        site: @site,
        application: @application,
      )
      application_instance_domain = "#{@application.key}.#{Rails.application.secrets.application_root_domain}"
      expect(@application_instance.domain).to eq(application_instance_domain)
    end

    it "sets a default secret" do
      @application_instance = create(:application_instance, site: @site, application: @application)
      expect(@application_instance.lti_secret).to be_present
    end

    it "sets a default tenant to the lti_key" do
      @application_instance = create(:application_instance, site: @site, application: @application)
      expect(@application_instance.tenant).to eq(@application_instance.lti_key)
    end

    it "sets anonymous to the value from application" do
      @application.anonymous = true
      @application.save!
      @application_instance = create(:application_instance, site: @site, application: @application)
      expect(@application_instance.anonymous).to eq(true)
    end

    it "doesn't change the tenant" do
      @application_instance = create(
        :application_instance,
        site: @site,
        application: @application,
        tenant: "bfcoder",
      )
      expect(@application_instance.tenant).to_not eq(@application_instance.lti_key)
      expect(@application_instance.tenant).to eq("bfcoder")
    end

    it "sets a valid lti_key using the key" do
      key = "a-test"
      application = create(:application, key: key)
      @application_instance = create(:application_instance, lti_key: nil, site: @site, application: application)
      expect(@application_instance.lti_key).to eq("#{@site.key}-#{key}")
    end

    it "doesn't set lti_key if the lti_key is already set" do
      lti_key = "the-lti-key"
      @application_instance = create(
        :application_instance,
        site: @site,
        lti_key: lti_key,
      )
      expect(@application_instance.lti_key).to eq(lti_key)
    end

    it "sets the config to the application default_config if blank" do
      app = create(:application, default_config: { foo: :bar })
      app_instance = create(:application_instance, application: app)
      expect(app_instance.config).to eq app.default_config
    end

    it "keeps the config to as entered" do
      app = create(:application, default_config: { foo: :bar })
      app_instance = create(:application_instance, application: app, config: { foo: :baz })
      expect(app_instance.config).to eq("foo" => "baz")
    end

    it "sets the lti_config to the application lti_config if blank" do
      app = create(:application, lti_config: { foo: :bar })
      app_instance = create(:application_instance, application: app)
      expect(app_instance.lti_config).to eq app.lti_config
    end

    it "keeps the lti_config to as entered" do
      app = create(:application, lti_config: { foo: :bar })
      app_instance = create(:application_instance, application: app, lti_config: { foo: :baz })
      expect(app_instance.lti_config).to eq("foo" => "baz")
    end

    it "is anonymous if the application is anonymous" do
      app = create(:application, anonymous: true)
      app_instance = create(:application_instance, application: app)
      expect(app_instance.anonymous).to eq(app.anonymous)
    end

    it "requires a site" do
      expect do
        create(:application_instance, site: nil, lti_key: "test")
      end.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "creates a schema upon creation" do
      expect(Apartment::Tenant).to receive(:create)
      @application_instance = create :application_instance
    end

    it "does not allow the name to be changed after creation" do
      @application_instance = create(:application_instance)
      @application_instance.lti_key = "new-lti-key"
      expect(@application_instance.valid?).to be false
    end

    it "generates the lti xml config" do
      lti_config = {
        title: "LTI Starter App",
        description: "The Atomic Jolt LTI Starter app",
        privacy_level: "public",
        icon: "oauth_icon.png",
      }
      app = create(:application, lti_config: lti_config)
      application_instance = create(:application_instance, application: app)
      xml = application_instance.lti_config_xml
      doc = Nokogiri::XML(xml)
      doc.xpath("//lticm:property").each do |lti_property|
        if lti_property.attributes["name"].value == "privacy_level"
          expect(lti_property.children.text).to eq("public")
        elsif lti_property.attributes["name"].value == "domain"
          expect(lti_property.children.text).to eq(application_instance.domain)
        end
      end
    end

    it "generates the lti xml config with privacy_level anonymous" do
      lti_config = {
        title: "LTI Starter App",
        description: "The Atomic Jolt LTI Starter app",
        privacy_level: "public",
        icon: "oauth_icon.png",
      }
      app = create(:application, lti_config: lti_config)
      application_instance = create(:application_instance, application: app, anonymous: true)
      xml = application_instance.lti_config_xml
      doc = Nokogiri::XML(xml)
      doc.xpath("//lticm:property").each do |lti_property|
        if lti_property.attributes["name"].value == "privacy_level"
          expect(lti_property.children.text).to eq("anonymous")
        elsif lti_property.attributes["name"].value == "domain"
          expect(lti_property.children.text).to eq(application_instance.domain)
        end
      end
    end
  end

  describe "match_application_instance" do
    let(:client_id) { FactoryBot.generate(:client_id) }
    let(:deployment_id) { FactoryBot.generate(:deployment_id) }
    let(:iss) { "https://canvas.instructure.com" }
    let(:lms_url) { FactoryBot.generate(:url) }
    let!(:site) { FactoryBot.create(:site, url: lms_url) }
    let!(:application) { FactoryBot.create(:application) }
    let!(:lti_install) { FactoryBot.create(:lti_install, iss: iss, client_id: client_id, application: application) }
    context "application instance already has an lti deployment" do
      it "returns nil" do
        application_instance = FactoryBot.create(:application_instance, application: application)
        other_deployment_id = "other"
        application_instance.lti_deployments.create!(lti_install: lti_install, deployment_id: other_deployment_id)
        ret = described_class.match_application_instance(lti_install, deployment_id)
        expect(ret).to eq(nil)
      end
    end
    context "application instance does not have an lti deployment" do
      it "returns the application instance" do
        application_instance = FactoryBot.create(:application_instance, application: application)
        ret = described_class.match_application_instance(lti_install, deployment_id)
        expect(ret).to eq(application_instance)
        lti_deployment = application_instance.lti_deployments.first
        expect(lti_deployment.deployment_id).to eq(deployment_id)
      end
    end
  end

  describe ".by_client_and_deployment" do
    context "when there is a matching LtiInstall" do
      let(:client_id) { FactoryBot.generate(:client_id) }
      let(:deployment_id) { FactoryBot.generate(:deployment_id) }
      let(:iss) { "https://canvas.instructure.com" }
      let(:lms_url) { FactoryBot.generate(:url) }

      let!(:site) { FactoryBot.create(:site, url: lms_url) }
      let!(:lti_install) { FactoryBot.create(:lti_install, iss: iss, client_id: client_id) }

      context "when there isn't a matching ApplicationInstance" do
        it "creates an ApplicationInstance" do
          expect do
            described_class.by_client_and_deployment(client_id, deployment_id, iss, lms_url)
          end.to change(described_class, :count).from(1).to(2)
        end

        it "associates the ApplicationInstance with the correct site" do
          application_instance = described_class.by_client_and_deployment(client_id, deployment_id, iss, lms_url)

          expect(application_instance.site).to eq(site)
        end

        it "creates an LtiDeployment" do
          expect do
            described_class.by_client_and_deployment(client_id, deployment_id, iss, lms_url)
          end.to change(LtiDeployment, :count).from(0).to(1)
        end

        it "associates the LtiDeployment with the correct ApplicationInstance" do
          application_instance = described_class.by_client_and_deployment(client_id, deployment_id, iss, lms_url)

          lti_deployment = LtiDeployment.last

          expect(lti_deployment.application_instance).to eq(application_instance)
        end

        it "associates the LtiDeployment with the correct LtiInstall" do
          described_class.by_client_and_deployment(client_id, deployment_id, iss, lms_url)

          lti_deployment = LtiDeployment.last

          expect(lti_deployment.lti_install).to eq(lti_install)
        end

        it "gives the LtiDeployment the correct deployment_id" do
          described_class.by_client_and_deployment(client_id, deployment_id, iss, lms_url)

          lti_deployment = LtiDeployment.last

          expect(lti_deployment.deployment_id).to eq(deployment_id)
        end
      end
    end
  end

  describe "#token_url" do
    let(:customer_canvas_url) { "https://customer.instructure.com" }
    let(:site) { FactoryBot.create(:site, url: customer_canvas_url) }
    let(:application_instance) { FactoryBot.create(:application_instance, site: site) }
    let(:client_id) { FactoryBot.generate(:client_id) }

    def create_lti_install(iss, token_url)
      FactoryBot.create(
        :lti_install,
        application: application_instance.application,
        iss: iss,
        client_id: client_id,
        token_url: token_url,
      )
    end

    context "when the URL is not a Canvas URL" do
      let(:iss) { "https://www.sakaii.com" }
      let(:token_url) { "https://www.sakaii.com/login/oauth2/token" }

      before do
        create_lti_install(iss, token_url)
      end

      it "returns the token_url from the LtiInstall record" do
        result = application_instance.token_url(iss, client_id)

        expect(result).to eq(token_url)
      end
    end

    context "when the URL is a Canvas URL" do
      let(:iss) { "https://canvas.instructure.com" }
      let(:token_url) { "https://canvas.instructure.com/login/oauth2/token" }

      before do
        create_lti_install(iss, token_url)
      end

      it "returns the customer specific token_url" do
        result = application_instance.token_url(iss, client_id)

        expect(result).to eq("#{customer_canvas_url}/login/oauth2/token")
      end
    end

    context "when the URL is a Canvas Beta URL" do
      let(:iss) { "https://canvas.instructure.com" }
      let(:token_url) { "https://canvas.beta.instructure.com/login/oauth2/token" }

      before do
        create_lti_install(iss, token_url)
      end

      it "returns the customer specific token_url" do
        result = application_instance.token_url(iss, client_id)

        expect(result).to eq("#{customer_canvas_url}/login/oauth2/token")
      end
    end
  end
end
