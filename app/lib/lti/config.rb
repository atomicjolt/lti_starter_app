# https://canvas.instructure.com/doc/api/tools_xml.html
# LTI gem docs: https://github.com/instructure/ims-lti

# These are the available LTI placements in Canvas.
# Placements that are implemented:
# account_navigation
# course_navigation
# editor_button
# global_navigation
# link_selection
# post_grades
# resource_selection
# assignment_selection
# user_navigation
# assignment_configuration
# assignment_menu
# collaboration
# course_home_sub_navigation
# course_settings_sub_navigation
# discussion_topic_menu
# file_menu
# homework_submission
# migration_selection
# module_menu
# quiz_menu
# tool_configuration
# wiki_page_menu

module Lti

  class Config

    def self.xml(args = {})
      config(args).to_xml(indent: 2)
    end

    def self.config(args = {})
      tc = tool_config(args)

      canvas_ext_config = default_config(args)
      canvas_ext_config = custom_fields_from_args(canvas_ext_config, args)
      canvas_ext_config = resource_selection_from_args(canvas_ext_config, args)
      canvas_ext_config = course_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = account_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = editor_button_from_args(canvas_ext_config, args)
      canvas_ext_config = assignment_selection_from_args(canvas_ext_config, args)
      canvas_ext_config = link_selection_from_args(canvas_ext_config, args)
      canvas_ext_config = user_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = global_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = post_grades_from_args(canvas_ext_config, args)
      canvas_ext_config = assignment_configuration_from_args(canvas_ext_config, args)
      canvas_ext_config = assignment_menu_from_args(canvas_ext_config, args)
      canvas_ext_config = collaboration_from_args(canvas_ext_config, args)
      canvas_ext_config = course_home_sub_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = course_settings_sub_navigation_from_args(canvas_ext_config, args)
      canvas_ext_config = discussion_topic_menu_from_args(canvas_ext_config, args)
      canvas_ext_config = file_menu_from_args(canvas_ext_config, args)
      canvas_ext_config = homework_submission_from_args(canvas_ext_config, args)
      canvas_ext_config = migration_selection_from_args(canvas_ext_config, args)
      canvas_ext_config = module_menu_from_args(canvas_ext_config, args)
      canvas_ext_config = quiz_menu_from_args(canvas_ext_config, args)
      canvas_ext_config = tool_configuration_from_args(canvas_ext_config, args)
      canvas_ext_config = wiki_page_menu_from_args(canvas_ext_config, args)

      tc.set_ext_params("canvas.instructure.com", canvas_ext_config.stringify_keys)
      tc
    end

    def self.tool_config(args = {})
      IMS::LTI::Services::ToolConfig.new(
        title: args[:title],
        launch_url: args[:launch_url],
        secure_launch_url: args[:secure_launch_url],
        description: args[:description],
        icon: "https://#{args[:domain]}/#{args[:icon]}",
      )
    end

    def self.default_config(args = {})
      {
        "privacy_level" => args[:privacy_level] || "public",
        "domain" => args[:domain],
      }
    end

    def self.custom_fields_from_args(config = {}, args = {})
      if args[:custom_fields].present?
        config["custom_fields"] = args[:custom_fields]
      end
      config
    end

    def self.resource_selection_from_args(config = {}, args = {})
      if args[:resource_selection].present?
        config["resource_selection"] = args[:resource_selection].stringify_keys
        default_configs_from_args!(args, config, :resource_selection)
        default_dimensions!(config, "resource_selection")
      end
      config
    end

    def self.global_navigation_from_args(config = {}, args = {})
      if args[:global_navigation].present?
        default_configs_from_args!(args, config, :global_navigation)
      end
      config
    end

    def self.user_navigation_from_args(config = {}, args = {})
      if args[:user_navigation].present?
        default_configs_from_args!(args, config, :user_navigation)
      end
      config
    end

    def self.course_navigation_from_args(config = {}, args = {})
      if args[:course_navigation].present?
        default_configs_from_args!(args, config, :course_navigation)
      end
      config
    end

    def self.account_navigation_from_args(config = {}, args = {})
      if args[:account_navigation].present?
        default_configs_from_args!(args, config, :account_navigation)
      end
      config
    end

    def self.post_grades_from_args(config = {}, args = {})
      if args[:post_grades].present?
        default_configs_from_args!(args, config, :post_grades)
      end
      config
    end

    def self.editor_button_from_args(config = {}, args = {})
      if args[:editor_button].present?
        config["editor_button"] = args[:editor_button].stringify_keys
        config["editor_button"]["icon_url"] = "https://#{args[:domain]}/#{args[:editor_button][:icon_url]}"
        config["editor_button"].delete("icon")
        selection_config_from_args!(args, config, "editor_button")
        default_dimensions!(config, "editor_button")
      end
      config
    end

    def self.assignment_selection_from_args(config = {}, args = {})
      if args[:assignment_selection].present?
        config["assignment_selection"] = args[:assignment_selection].stringify_keys
        selection_config_from_args!(args, config, "assignment_selection")
        default_dimensions!(config, "assignment_selection")
      end
      config
    end

    def self.link_selection_from_args(config = {}, args = {})
      if args[:link_selection].present?
        config["link_selection"] = args[:link_selection].stringify_keys
        selection_config_from_args!(args, config, "link_selection")
        default_dimensions!(config, "link_selection")
      end
      config
    end

    def self.assignment_configuration_from_args(config = {}, args = {})
      if args[:assignment_configuration].present?
        default_configs_from_args!(args, config, :assignment_configuration)
      end
      config
    end

    def self.assignment_menu_from_args(config = {}, args = {})
      if args[:assignment_menu].present?
        default_configs_from_args!(args, config, :assignment_menu)
      end
      config
    end

    def self.collaboration_from_args(config = {}, args = {})
      if args[:collaboration].present?
        default_configs_from_args!(args, config, :collaboration)
      end
      config
    end

    def self.course_home_sub_navigation_from_args(config = {}, args = {})
      if args[:course_home_sub_navigation].present?
        default_configs_from_args!(args, config, :course_home_sub_navigation)
      end
      config
    end

    def self.course_settings_sub_navigation_from_args(config = {}, args = {})
      if args[:course_settings_sub_navigation].present?
        default_configs_from_args!(args, config, :course_settings_sub_navigation)
      end
      config
    end

    def self.discussion_topic_menu_from_args(config = {}, args = {})
      if args[:discussion_topic_menu].present?
        default_configs_from_args!(args, config, :discussion_topic_menu)
      end
      config
    end

    def self.file_menu_from_args(config = {}, args = {})
      if args[:file_menu].present?
        default_configs_from_args!(args, config, :file_menu)
      end
      config
    end

    def self.homework_submission_from_args(config = {}, args = {})
      if args[:homework_submission].present?
        default_configs_from_args!(args, config, :homework_submission)
      end
      config
    end

    def self.migration_selection_from_args(config = {}, args = {})
      if args[:migration_selection].present?
        default_configs_from_args!(args, config, :migration_selection)
      end
      config
    end

    def self.module_menu_from_args(config = {}, args = {})
      if args[:module_menu].present?
        default_configs_from_args!(args, config, :module_menu)
      end
      config
    end

    def self.quiz_menu_from_args(config = {}, args = {})
      if args[:quiz_menu].present?
        default_configs_from_args!(args, config, :quiz_menu)
      end
      config
    end

    def self.tool_configuration_from_args(config = {}, args = {})
      if args[:tool_configuration].present?
        default_configs_from_args!(args, config, :tool_configuration)
      end
      config
    end

    def self.wiki_page_menu_from_args(config = {}, args = {})
      if args[:wiki_page_menu].present?
        default_configs_from_args!(args, config, :wiki_page_menu)
      end
      config
    end

    def self.default_dimensions!(config, key)
      config[key]["selection_width"] ||= "892"
      config[key]["selection_height"] ||= "800"
    end

    def self.selection_config_from_args!(args, config, key)
      config[key]["message_type"] ||= "ContentItemSelectionRequest"
      config[key]["url"] ||= args[:launch_url]
      config
    end

    def self.default_configs_from_args!(args, config, key)
      config[key] = args[key].stringify_keys
      config[key]["url"] ||= args[:launch_url]
      config[key]["default"] ||= "enabled"
      config[key]["visibility"] ||= "admins"
    end

  end

end
