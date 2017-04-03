# https://canvas.instructure.com/doc/api/tools_xml.html
# LTI gem docs: https://github.com/instructure/ims-lti
module Lti

  class Config

    def self.xml(args = {})
      config(args).to_xml(indent: 2)
    end

    def self.course_navigation(config)
      config[:course_navigation] = {
        text: config[:title],
        visibility: config[:visibility] || "public",
        default: "enabled",
        enabled: true,
      }
      config
    end

    def self.account_navigation(config)
      config[:account_navigation] = {
        text: config[:title],
        visibility: config[:visibility] || "admins",
        default: "enabled",
        enabled: true,
      }
      config
    end

    def self.config(args = {})
      title = args[:title]

      tc = tool_config(title, args)

      config = default_config(args)
      config = resource_selection_from_args(config, title, args)
      config = course_navigation_from_args(config, args)
      config = account_navigation_from_agrs(config, args)
      config = editor_button_from_agrs(config, title, args)

      tc.set_ext_params("canvas.instructure.com", config)
      tc
    end

    def self.tool_config(title = "", args = {})
      IMS::LTI::ToolConfig.new(
        title: title,
        launch_url: args[:launch_url],
        description: args[:description],
        icon: args[:icon],
      )
    end

    def self.default_config(args = {})
      {
        "privacy_level" => "public",
        "domain" => args[:domain],
      }
    end

    def self.resource_selection_from_args(config = {}, title = "", args = {})
      if args[:course_navigation].blank? && args[:account_navigation].blank?
        config["resource_selection"] = {
          "url" => args[:launch_url],
          "text" => title,
          "selection_width" => "892",
          "selection_height" => "800",
        }
      end
      config
    end

    def self.course_navigation_from_args(config = {}, args = {})
      if args[:course_navigation].present?
        config["course_navigation"] = {
          "url" => args[:launch_url],
          "default" => args[:course_navigation][:default] || "enabled",
          "text" => args[:course_navigation][:text],
          "enabled" => args[:course_navigation][:enabled],
        }
        if args[:course_navigation][:visibility]
          config["course_navigation"]["visibility"] = args[:course_navigation][:visibility]
        end
      end
      config
    end

    def self.account_navigation_from_agrs(config = {}, args = {})
      if args[:account_navigation].present?
        config["account_navigation"] = {
          "url" => args[:launch_url],
          "default" => args[:account_navigation][:default] || "enabled",
          "visibility" => args[:account_navigation][:visibility] || "public",
          "text" => args[:account_navigation][:text],
          "enabled" => args[:account_navigation][:enabled],
        }
      end
      config
    end

    def self.editor_button_from_agrs(config = {}, title = "", args = {})
      if args[:button_url].present?
        config["editor_button"] = {
          "url" => args[:launch_url],
          "icon_url" => args[:button_url],
          "text" => args[:button_text] || title,
          "selection_width" => "892",
          "selection_height" => "800",
        }
      end
      config
    end

  end

end
