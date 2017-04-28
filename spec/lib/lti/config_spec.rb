require "rails_helper"

RSpec.describe Lti::Config do
  before do
    @domain = "www.example.com"
    @launch_url = "https://#{@domain}/lti_launches"
    @basic_config = {
      launch_url: @launch_url,
      title: "Atomic LTI test",
      description: "This is the test application for the Atomic LTI engine",
      icon: "#{@domain}/images/oauth_icon.png",
      domain: @domain,
    }
  end

  describe "xml" do
    it "generates basic configuration xml for an LTI tool" do
      xml = described_class.xml(@basic_config)
      expect(xml).to be_present
      basic_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:icon>#{@basic_config[:icon]}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">#{@domain}</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(basic_xml)
    end

    it "generates extended configuration xml for an LTI tool with a assignment selection" do
      assignment_selection = {
        canvas_icon_class: "icon-lti",
        message_type: "ContentItemSelectionRequest",
        url: @launch_url,
        selection_width: 50,
        selection_height: 50,
      }
      args = @basic_config.merge({ assignment_selection: assignment_selection })
      xml = described_class.xml(args)
      expect(xml).to be_present
      assignment_selection_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:icon>#{@basic_config[:icon]}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="assignment_selection">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="message_type">ContentItemSelectionRequest</lticm:property>
              <lticm:property name="selection_height">50</lticm:property>
              <lticm:property name="selection_width">50</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
            </lticm:options>
            <lticm:property name="domain">#{@domain}</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(assignment_selection_xml)
    end

    it "generates extended configuration xml for an LTI tool with a link selection" do
      link_selection = {
        canvas_icon_class: "icon-lti",
        message_type: "ContentItemSelectionRequest",
        url: @launch_url,
        selection_width: 50,
        selection_height: 50,
      }
      args = @basic_config.merge({ link_selection: link_selection })
      xml = described_class.xml(args)
      expect(xml).to be_present
      link_selection_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:icon>#{@basic_config[:icon]}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">#{@domain}</lticm:property>
            <lticm:options name="link_selection">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="message_type">ContentItemSelectionRequest</lticm:property>
              <lticm:property name="selection_height">50</lticm:property>
              <lticm:property name="selection_width">50</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(link_selection_xml)
    end

    it "generates extended configuration xml for an LTI tool with an editor button" do
      button_url = "http://www.example.com/button_image.png"
      button_text = "Custom Button"
      editor_button = {
        canvas_icon_class: "icon-lti",
        icon_url: button_url,
        message_type: "ContentItemSelectionRequest",
        text: button_text,
        url: @launch_url,
        label: button_text,
        selection_width: 50,
        selection_height: 50,
      }
      args = @basic_config.merge({ editor_button: editor_button })
      xml = described_class.xml(args)
      expect(xml).to be_present
      button_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:icon>#{@basic_config[:icon]}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">#{@domain}</lticm:property>
            <lticm:options name="editor_button">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="icon_url">#{button_url}</lticm:property>
              <lticm:property name="label">#{button_text}</lticm:property>
              <lticm:property name="message_type">ContentItemSelectionRequest</lticm:property>
              <lticm:property name="selection_height">50</lticm:property>
              <lticm:property name="selection_width">50</lticm:property>
              <lticm:property name="text">#{button_text}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(button_xml)
    end

    it "generates extended configuration xml for an LTI tool with a course navigation" do
      icon_url = "http://www.example.com/button_image.png"
      course_navigation = {
        text: "Course level tool",
        visibility: "admins",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ course_navigation: course_navigation })
      xml = described_class.xml(args)
      expect(xml).to be_present
      course_navigation_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:icon>#{@basic_config[:icon]}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="course_navigation">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{course_navigation[:icon_url]}</lticm:property>
              <lticm:property name="text">#{course_navigation[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">admins</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(course_navigation_xml)
    end

    it "generates extended configuration xml for an LTI tool with a account navigation" do
      icon_url = "http://www.example.com/button_image.png"
      account_navigation = {
        text: "test",
        visibility: "admins",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        label: "test",
      }
      args = @basic_config.merge({ account_navigation: account_navigation })
      xml = described_class.xml(args)
      expect(xml).to be_present
      account_navigation_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:icon>#{@basic_config[:icon]}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="account_navigation">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{account_navigation[:icon_url]}</lticm:property>
              <lticm:property name="label">test</lticm:property>
              <lticm:property name="text">#{account_navigation[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">admins</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(account_navigation_xml)
    end

    it "generates xml with the given title" do
      title = "LTI Tool Title"
      args = {
        launch_url: @launch_url,
        title: title,
      }
      xml = described_class.xml(args)
      expect(xml).to be_present
      expect(xml).to include(title)
    end
    it "generates xml with the given description" do
      description = "LTI Tool Description"
      args = {
        launch_url: @launch_url,
        description: description,
      }
      xml = described_class.xml(args)
      expect(xml).to be_present
      expect(xml).to include(description)
    end
  end
end
