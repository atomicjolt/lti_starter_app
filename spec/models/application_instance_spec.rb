require "rails_helper"

RSpec.describe ApplicationInstance, type: :model do
  describe "create application" do
    before :each do
      @site = create(:site)
      @name = "test"
      @application = create(:application, name: @name, key: @name)
    end

    it "sets a default lti key" do
      @application_instance = create(:application_instance, lti_key: nil, site: @site, application: @application)
      expect(@application_instance.lti_key).to eq(@name)
    end

    it "generates a key based on the site and application" do
      @application_instance = create(:application_instance, lti_key: nil, site: @site, application: @application)
      expect(@application_instance.key).to eq("#{@site.subdomain}-#{@application.key}")
    end

    it "sets a default domain" do
      @application_instance = create(
        :application_instance,
        lti_key: nil,
        domain: nil,
        site: @site,
        application: @application,
      )
      application_instance_domain = "#{@application_instance.key}.#{Rails.application.secrets.application_root_domain}"
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
      expect(@application_instance.lti_key).to eq(key)
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
  end
end
