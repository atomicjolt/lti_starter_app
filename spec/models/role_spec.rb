require "rails_helper"

describe Role, type: :model do
  it "should find matching roles with or without context" do
    context_id = "1234"
    role = FactoryGirl.create(:role)
    role1 = FactoryGirl.create(:role, context_id: context_id)
    role2 = FactoryGirl.create(:role, context_id: "asdf1234")
    roles = Role.by_nil_or_context(context_id)
    expect(roles.include?(role)).to be true
    expect(roles.include?(role1)).to be true
    expect(roles.include?(role2)).to be false
  end
end
