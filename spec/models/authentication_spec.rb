require "rails_helper"

RSpec.describe Authentication, type: :model do
  it { should belong_to :user }
  it "Requires the provider" do
    authentication = FactoryGirl.build(:authentication, provider: nil)
    expect(authentication.save).to eq(false)
  end

  describe "valid?" do
    it "is true when provider is unique" do
      provider = "asdf1234"
      authentication = create(:authentication, provider: provider)
      expect(authentication.valid?).to be true
    end

    it "is false for duplicate provider" do
      provider = "asdf1234"
      uid = "1234aoeu"
      user_id = 3
      provider_url = "example.com"
      create(
        :authentication,
        provider: provider,
        uid: uid,
        user_id: user_id,
        provider_url: provider_url,
      )
      authentication = build(
        :authentication,
        provider: provider,
        uid: uid,
        user_id: user_id,
        provider_url: provider_url,
      )
      expect(authentication.valid?(provider)).to be false
    end

    it "is false when provider is missing" do
      provider = nil
      authentication = build(:authentication, provider: provider)
      expect(authentication.valid?).to be false
    end
  end

  describe "for_auth" do
    it "finds an authentication given an auth object from omniauth" do
      auth = get_canvas_auth
      attributes = Authentication.authentication_attrs_from_auth(auth)
      Authentication.create!(attributes)
      authentication = Authentication.for_auth(auth)
      expect(authentication.provider_url).to eq auth["info"]["url"]
    end
    it "finds the correct authentication object when UIDs are duplicated" do
      canvas1 = {
        "uid" => "123",
        "info" => {
          "url" => "https://atomicjolt.instructure.com",
        },
      }
      canvas2 = {
        "uid" => "123",
        "info" => {
          "url" => "https://canvas.instructure.com",
        },
      }
      auth1 = get_canvas_auth(canvas1)
      auth2 = get_canvas_auth(canvas2)

      attributes1 = Authentication.authentication_attrs_from_auth(auth1)
      Authentication.create!(attributes1)

      attributes2 = Authentication.authentication_attrs_from_auth(auth2)
      Authentication.create!(attributes2)

      authentication1 = Authentication.for_auth(auth1)
      authentication2 = Authentication.for_auth(auth2)

      expect(authentication1.id).to_not eq(authentication2.id)
      expect(authentication1.uid).to eq(canvas1["uid"])
      expect(authentication2.uid).to eq(canvas1["uid"])

      expect(authentication1.provider_url).to eq(canvas1["info"]["url"])
      expect(authentication2.provider_url).to eq(canvas2["info"]["url"])
    end
  end

  describe "authentication_attrs_from_auth" do
    it "generates authentication attributes from an omniauth auth object" do
      auth = get_canvas_auth
      attributes = Authentication.authentication_attrs_from_auth(auth)
      expect(attributes[:uid]).to eq auth["uid"].to_s
      expect(attributes[:username]).to eq auth["info"]["nickname"]
      expect(attributes[:provider]).to eq auth["provider"]
      expect(attributes[:provider_url]).to eq auth["info"]["url"]
      expect(attributes[:lti_user_id]).to eq auth["extra"]["raw_info"]["lti_user_id"]
    end
  end

  describe "copy_to_tenant" do
    context "copies the authentication to given tenant" do
      before do
        @site = create(:site)
        @name = "An Example application"
        @key = "example"
        @application = create(:application, name: @name, key: @key)
        lti_key = "atomic-key"
        @application_instance = create(
          :application_instance,
          lti_key: lti_key,
          site: @site,
          application: @application,
        )
      end

      it "for a User" do
        auth = create(:authentication)
        user = create(:user)
        tenant_user = User.create_on_tenant(@application_instance, user)
        tenant_auth = auth.copy_to_tenant(@application_instance, tenant_user)
        Apartment::Tenant.switch(@application_instance.tenant) do
          found_user = User.find_by(email: tenant_user.email)
          expect(found_user.authentications.last.token).to eq(tenant_auth.token)
        end
      end
    end
  end
end
