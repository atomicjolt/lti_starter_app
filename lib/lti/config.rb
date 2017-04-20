# https://canvas.instructure.com/doc/api/tools_xml.html
# LTI gem docs: https://github.com/instructure/ims-lti
module Lti

  class Config

    def self.xml(args = {})
      config(args).to_xml(indent: 2)
    end

    def self.config(args = {})
      tc = tool_config(args)

      canvas_ext_config = default_config(args)
      canvas_ext_config = resource_selection_from_args(canvas_ext_config, args)
      canvas_ext_config = course_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = account_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = editor_button_from_args(canvas_ext_config, args)

      tc.set_ext_params("canvas.instructure.com", canvas_ext_config.stringify_keys)
      tc
    end

    def self.tool_config(args = {})
      IMS::LTI::ToolConfig.new(
        title: args[:title],
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

    def self.resource_selection_from_args(config = {}, args = {})
      if args[:resource_selection].present?
        config["resource_selection"] = {
          "url" => args[:launch_url],
          "text" => args[:title],
          "selection_width" => "892",
          "selection_height" => "800",
        }
      end
      config
    end

    def self.course_navigation_from_args(config = {}, args = {})
      if args[:course_navigation].present?
        config[:course_navigation] = args[:course_navigation].stringify_keys
        config[:course_navigation]["url"] ||= args[:launch_url]
        config[:course_navigation]["default"] ||= "enabled"
      end
      config
    end

    def self.account_navigation_from_args(config = {}, args = {})
      if args[:account_navigation].present?
        config[:account_navigation] = args[:account_navigation].stringify_keys
        config[:account_navigation]["url"] ||= args[:launch_url]
        config[:account_navigation]["default"] ||= "enabled"
      end
      config
    end

    def self.editor_button_from_args(config = {}, args = {})
      if args[:editor_button].present?
        settings = {
          "canvas_icon_class" => "icon-lti",
          "message_type" => "ContentItemSelectionRequest",
          "url" => args[:launch_url],
          "selection_width" => "892",
          "selection_height" => "800",
        }
        config["editor_button"] = args[:editor_button].merge(settings).stringify_keys
      end
      config
    end

  end

end
