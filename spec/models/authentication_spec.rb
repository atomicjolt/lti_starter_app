require "spec_helper"

describe Authentication, type: :model do
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
end
