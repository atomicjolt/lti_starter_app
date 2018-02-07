require "rails_helper"

RSpec.describe Lti::Config do
  before do
    @domain = "www.example.com"
    @launch_url = "https://#{@domain}/lti_launches"
    @import_url = "https://#{@domain}/api/ims_imports"
    @export_url = "https://#{@domain}/api/ims_exports"
    @basic_config = {
      secure_launch_url: @launch_url,
      launch_url: @launch_url,
      export_url: @export_url,
      import_url: @import_url,
      title: "Atomic LTI test",
      description: "This is the test application for the Atomic LTI engine",
      icon: "oauth_icon.png",
      domain: @domain,
    }
    @icon_url = "https://#{@basic_config[:domain]}/#{@basic_config[:icon]}"
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
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">#{@domain}</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(basic_xml)
    end

    it "generates basic configuration with custom fields xml for an LTI tool" do
      custom_fields = {
         canvas_api_domain: "$Canvas.api.domain",
         canvas_user_id: "$Canvas.user.id",
      }
      args = @basic_config.merge({ custom_fields: custom_fields })
      xml = described_class.xml(args)
      expect(xml).to be_present
      basic_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="custom_fields">
              <lticm:property name="canvas_api_domain">$Canvas.api.domain</lticm:property>
              <lticm:property name="canvas_user_id">$Canvas.user.id</lticm:property>
            </lticm:options>
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
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
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
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
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
      button_text = "Custom Button"
      editor_button = {
        canvas_icon_class: "icon-lti",
        icon: "button_image.png",
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
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">#{@domain}</lticm:property>
            <lticm:options name="editor_button">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="icon_url">#{"https://#{args[:domain]}/#{editor_button[:icon_url]}"}</lticm:property>
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

    it "generates extended configuration xml for an LTI tool with a global navigation" do
      icon_url = "http://www.example.com/button_image.png"
      global_navigation = {
        text: "Global level tool",
        visibility: "admins",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ global_navigation: global_navigation })
      xml = described_class.xml(args)
      expect(xml).to be_present
      global_navigation_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:options name="global_navigation">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{global_navigation[:icon_url]}</lticm:property>
              <lticm:property name="text">#{global_navigation[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">admins</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(global_navigation_xml)
    end

    it "generates extended configuration xml for an LTI tool with a user navigation" do
      icon_url = "http://www.example.com/button_image.png"
      user_navigation = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ user_navigation: user_navigation })
      xml = described_class.xml(args)
      expect(xml).to be_present
      user_navigation_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
            <lticm:options name="user_navigation">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{user_navigation[:icon_url]}</lticm:property>
              <lticm:property name="text">#{user_navigation[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(user_navigation_xml)
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
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
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
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
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

    it "generates extended configuration xml for an LTI tool with a post grades placement" do
      icon_url = "http://www.example.com/button_image.png"
      post_grades = {
        text: "post grades",
        visibility: "admins",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        label: "post grades",
      }
      args = @basic_config.merge({ post_grades: post_grades })
      xml = described_class.xml(args)
      expect(xml).to be_present
      post_grades_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:options name="post_grades">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{post_grades[:icon_url]}</lticm:property>
              <lticm:property name="label">post grades</lticm:property>
              <lticm:property name="text">#{post_grades[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">admins</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(post_grades_xml)
    end

    it "generates extended configuration xml for an LTI tool with a assignment_configuration placement" do
      icon_url = "http://www.example.com/button_image.png"
      assignment_configuration = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ assignment_configuration: assignment_configuration })
      xml = described_class.xml(args)
      expect(xml).to be_present
      assignment_configuration_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="assignment_configuration">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{assignment_configuration[:icon_url]}</lticm:property>
              <lticm:property name="text">#{assignment_configuration[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(assignment_configuration_xml)
    end

    it "generates extended configuration xml for an LTI tool with a assignment_menu placement" do
      icon_url = "http://www.example.com/button_image.png"
      assignment_menu = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ assignment_menu: assignment_menu })
      xml = described_class.xml(args)
      expect(xml).to be_present
      assignment_menu_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="assignment_menu">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{assignment_menu[:icon_url]}</lticm:property>
              <lticm:property name="text">#{assignment_menu[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(assignment_menu_xml)
    end

    it "generates extended configuration xml for an LTI tool with a collaboration placement" do
      icon_url = "http://www.example.com/button_image.png"
      collaboration = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ collaboration: collaboration })
      xml = described_class.xml(args)
      expect(xml).to be_present
      collaboration_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="collaboration">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{collaboration[:icon_url]}</lticm:property>
              <lticm:property name="text">#{collaboration[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(collaboration_xml)
    end

    it "generates extended configuration xml for an LTI tool with a course_home_sub_navigation placement" do
      icon_url = "http://www.example.com/button_image.png"
      course_home_sub_navigation = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ course_home_sub_navigation: course_home_sub_navigation })
      xml = described_class.xml(args)
      expect(xml).to be_present
      course_home_sub_navigation_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="course_home_sub_navigation">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{course_home_sub_navigation[:icon_url]}</lticm:property>
              <lticm:property name="text">#{course_home_sub_navigation[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(course_home_sub_navigation_xml)
    end

    it "generates extended configuration xml for an LTI tool with a course_settings_sub_navigation placement" do
      icon_url = "http://www.example.com/button_image.png"
      course_settings_sub_navigation = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ course_settings_sub_navigation: course_settings_sub_navigation })
      xml = described_class.xml(args)
      expect(xml).to be_present
      course_settings_sub_navigation_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="course_settings_sub_navigation">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{course_settings_sub_navigation[:icon_url]}</lticm:property>
              <lticm:property name="text">#{course_settings_sub_navigation[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(course_settings_sub_navigation_xml)
    end

    it "generates extended configuration xml for an LTI tool with a discussion_topic_menu placement" do
      icon_url = "http://www.example.com/button_image.png"
      discussion_topic_menu = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ discussion_topic_menu: discussion_topic_menu })
      xml = described_class.xml(args)
      expect(xml).to be_present
      discussion_topic_menu_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="discussion_topic_menu">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{discussion_topic_menu[:icon_url]}</lticm:property>
              <lticm:property name="text">#{discussion_topic_menu[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(discussion_topic_menu_xml)
    end

    it "generates extended configuration xml for an LTI tool with a file_menu placement" do
      icon_url = "http://www.example.com/button_image.png"
      file_menu = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ file_menu: file_menu })
      xml = described_class.xml(args)
      expect(xml).to be_present
      file_menu_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:options name="file_menu">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{file_menu[:icon_url]}</lticm:property>
              <lticm:property name="text">#{file_menu[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(file_menu_xml)
    end

    it "generates extended configuration xml for an LTI tool with a homework_submission placement" do
      icon_url = "http://www.example.com/button_image.png"
      homework_submission = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ homework_submission: homework_submission })
      xml = described_class.xml(args)
      expect(xml).to be_present
      homework_submission_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:options name="homework_submission">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{homework_submission[:icon_url]}</lticm:property>
              <lticm:property name="text">#{homework_submission[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(homework_submission_xml)
    end

    it "generates extended configuration xml for an LTI tool with a migration_selection placement" do
      icon_url = "http://www.example.com/button_image.png"
      migration_selection = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ migration_selection: migration_selection })
      xml = described_class.xml(args)
      expect(xml).to be_present
      migration_selection_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:options name="migration_selection">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{migration_selection[:icon_url]}</lticm:property>
              <lticm:property name="text">#{migration_selection[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(migration_selection_xml)
    end

    it "generates extended configuration xml for an LTI tool with a module_menu placement" do
      icon_url = "http://www.example.com/button_image.png"
      module_menu = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ module_menu: module_menu })
      xml = described_class.xml(args)
      expect(xml).to be_present
      module_menu_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:options name="module_menu">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{module_menu[:icon_url]}</lticm:property>
              <lticm:property name="text">#{module_menu[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(module_menu_xml)
    end

    it "generates extended configuration xml for an LTI tool with a quiz_menu placement" do
      icon_url = "http://www.example.com/button_image.png"
      quiz_menu = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ quiz_menu: quiz_menu })
      xml = described_class.xml(args)
      expect(xml).to be_present
      quiz_menu_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
            <lticm:options name="quiz_menu">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{quiz_menu[:icon_url]}</lticm:property>
              <lticm:property name="text">#{quiz_menu[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(quiz_menu_xml)
    end

    it "generates extended configuration xml for an LTI tool with a tool_configuration placement" do
      icon_url = "http://www.example.com/button_image.png"
      tool_configuration = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ tool_configuration: tool_configuration })
      xml = described_class.xml(args)
      expect(xml).to be_present
      tool_configuration_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
            <lticm:options name="tool_configuration">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{tool_configuration[:icon_url]}</lticm:property>
              <lticm:property name="text">#{tool_configuration[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(tool_configuration_xml)
    end

    it "generates extended configuration xml for an LTI tool with a wiki_page_menu placement" do
      icon_url = "http://www.example.com/button_image.png"
      wiki_page_menu = {
        text: "user level tool",
        visibility: "members",
        default: "enabled",
        enabled: true,
        canvas_icon_class: "icon-lti",
        icon_url: icon_url,
        url: @launch_url,
        windowTarget: "_blank",
      }
      args = @basic_config.merge({ wiki_page_menu: wiki_page_menu })
      xml = described_class.xml(args)
      expect(xml).to be_present
      wiki_page_menu_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
            <lticm:options name="wiki_page_menu">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="default">enabled</lticm:property>
              <lticm:property name="enabled">true</lticm:property>
              <lticm:property name="icon_url">#{wiki_page_menu[:icon_url]}</lticm:property>
              <lticm:property name="text">#{wiki_page_menu[:text]}</lticm:property>
              <lticm:property name="url">#{@launch_url}</lticm:property>
              <lticm:property name="visibility">members</lticm:property>
              <lticm:property name="windowTarget">_blank</lticm:property>
            </lticm:options>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(wiki_page_menu_xml)
    end

    it "generates extended configuration xml for an LTI tool with a content_migration support set to true" do
      args = @basic_config.merge({ content_migration: true })
      xml = described_class.xml(args)
      expect(xml).to be_present
      expected_xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>#{@basic_config[:title]}</blti:title>
          <blti:description>#{@basic_config[:description]}</blti:description>
          <blti:launch_url>#{@launch_url}</blti:launch_url>
          <blti:secure_launch_url>#{@launch_url}</blti:secure_launch_url>
          <blti:icon>#{@icon_url}</blti:icon>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:options name="content_migration">
              <lticm:property name="export_start_url">#{@export_url}</lticm:property>
              <lticm:property name="import_start_url">#{@import_url}</lticm:property>
            </lticm:options>
            <lticm:property name="domain">www.example.com</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
      expect(xml).to eq(expected_xml)
    end

    it "generates xml with the given title" do
      title = "LTI Tool Title"
      args = {
        secure_launch_url: @launch_url,
        launch_url: @launch_url,
        export_url: @export_url,
        import_url: @import_url,
        title: title,
      }
      xml = described_class.xml(args)
      expect(xml).to be_present
      expect(xml).to include(title)
    end
    it "generates xml with the given description" do
      description = "LTI Tool Description"
      args = {
        secure_launch_url: @launch_url,
        launch_url: @launch_url,
        export_url: @export_url,
        import_url: @import_url,
        description: description,
      }
      xml = described_class.xml(args)
      expect(xml).to be_present
      expect(xml).to include(description)
    end
  end
end
