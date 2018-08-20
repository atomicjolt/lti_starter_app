require "rails_helper"

describe Integrations::CanvasApiSupport do
  before do
    @user = FactoryBot.create(:user)
    @canvas_course = FactoryBot.create(:canvas_course)
    @application_instance = FactoryBot.create(:application_instance, canvas_token: nil)
    @authentication = FactoryBot.create(
      :authentication,
      provider_url: UrlHelper.scheme_host_port(@application_instance.site.url),
      refresh_token: "asdf",
    )
  end
  it "should find an api using the user" do
    @user.authentications << @authentication
    @user.save!
    @api_support = Integrations::CanvasApiSupport.new(@user, @canvas_course, @application_instance)
    expect(@api_support.api).to be_present
  end
  it "should find an api using a course token" do
    @canvas_course.authentications << @authentication
    @canvas_course.save!
    @api_support = Integrations::CanvasApiSupport.new(@user, @canvas_course, @application_instance)
    expect(@api_support.api).to be_present
  end
  it "should find an api using an application token" do
    @application_instance.authentications << @authentication
    @application_instance.save!
    @api_support = Integrations::CanvasApiSupport.new(@user, @canvas_course, @application_instance)
    expect(@api_support.api).to be_present
  end
  it "should find an api using a global token" do
    application_instance = FactoryBot.create(:application_instance, canvas_token: 'afakecanvastoken')
    @api_support = Integrations::CanvasApiSupport.new(@user, @canvas_course, application_instance)
    expect(@api_support.api).to be_present
  end
end
