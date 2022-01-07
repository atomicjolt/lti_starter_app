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
# assignment_edit
# assignment_view
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

module LtiAdvantage
  class Config
    # Converts old lti into lti advantage
    # NOTE this is a work in progress and may not correctly convert all LTI configs.
    def self.lti_to_lti_advantage(jwk, domain, args = {})
      raise ::Exceptions::LtiConfigMissing, "Please provide an LTI launch url" if args[:launch_url].blank?
      raise ::Exceptions::LtiConfigMissing, "Please provide an LTI secure launch url" if args[:secure_launch_url].blank?

      if args[:content_migration].present?
        raise Exceptions::LtiConfigMissing, "Please provide an IMS export url" if args[:export_url].blank?
        raise Exceptions::LtiConfigMissing, "Please provide an IMS import url" if args[:import_url].blank?
      end

      {
        title: args[:title],
        scopes: LtiAdvantage::Definitions.scopes,
        icon: icon(domain, args),
        target_link_uri: args[:launch_url],
        oidc_initiation_url: "#{args[:launch_url]}/init",
        public_jwk: jwk.to_json,
        description: args[:description],
        custom_fields: custom_fields_from_args(domain, args[:title], args),
        extensions: [
          {
            "platform": "canvas.instructure.com",
            "domain": "https://#{domain}",
            "tool_id": "hellolti",
            "settings": {
              "privacy_level": "public",
              "text": args[:title],
              "icon_url": "https://#{domain}/atomicjolt.png",
              "selection_width": 500,
              "selection_height": 500,
              "placements": placements(domain, args[:title], args),
            },
          },
        ],
      }
    end

    def self.placements(domain, text, args)
      conf = []
      conf << placement_from_args(:resource_selection, domain, text, args)
      conf << placement_from_args(:global_navigation, domain, text, args)
      conf << placement_from_args(:user_navigation, domain, text, args)
      conf << placement_from_args(:course_navigation, domain, text, args)
      conf << placement_from_args(:account_navigation, domain, text, args)
      conf << placement_from_args(:post_grades, domain, text, args)
      conf << placement_from_args(:assignment_configuration, domain, text, args)
      conf << placement_from_args(:assignment_edit, domain, text, args)
      conf << placement_from_args(:assignment_menu, domain, text, args)
      conf << placement_from_args(:collaboration, domain, text, args)
      conf << placement_from_args(:course_home_sub_navigation, domain, text, args)
      conf << placement_from_args(:course_settings_sub_navigation, domain, text, args)
      conf << placement_from_args(:discussion_topic_menu, domain, text, args)
      conf << placement_from_args(:file_menu, domain, text, args)
      conf << placement_from_args(:homework_submission, domain, text, args)
      conf << placement_from_args(:migration_selection, domain, text, args)
      conf << placement_from_args(:quiz_menu, domain, text, args)
      conf << placement_from_args(:tool_configuration, domain, text, args)
      conf << editor_button_from_args(domain, text, args)
      conf << assignment_selection_from_args(domain, text, args)
      conf << link_selection_from_args(domain, text, args)
      conf << assignment_view_from_args(domain, text, args)
      conf << module_menu_from_args(domain, text, args)
      conf << wiki_page_menu_from_args(domain, text, args)
      conf << content_migration_args(domain, text, args)
      conf.compact
    end

    def self.icon(domain, args)
      if args[:icon].present?
        args[:icon].include?("http") ? args[:icon] : "https://#{domain}/#{args[:icon]}"
      end
    end

    def self.custom_fields_from_args(_domain, _text, args = {})
      custom_fields = {
        custom_canvas_api_domain: "$Canvas.api.domain",
      }
      if args[:custom_fields].present?
        custom_fields.merge(args[:custom_fields]).stringify_keys
      else
        custom_fields.stringify_keys
      end
    end

    def self.placement_from_args(placement, domain, text, args = {})
      if args[placement].present?
        default_configs_from_args(args, domain, text, placement).merge(
          args[:placement].stringify_keys,
        )
      end
    end

    def self.editor_button_from_args(domain, _text, args = {})
      if args[:editor_button].present?
        config = args[:editor_button].stringify_keys
        config["icon_url"] = "https://#{domain}/#{args[:editor_button][:icon_url]}"
        config.delete("icon")
        selection_config_from_args!(args, config, :editor_button)
      end
    end

    def self.assignment_selection_from_args(_domain, _text, args = {})
      if args[:assignment_selection].present?
        config = args[:assignment_selection].stringify_keys
        selection_config_from_args!(args, config, :assignment_selection)
      end
    end

    def self.link_selection_from_args(_domain, _text, args = {})
      if args[:link_selection].present?
        config = args[:link_selection].stringify_keys
        selection_config_from_args!(args, config, :link_selection)
      end
    end

    def self.assignment_view_from_args(domain, text, args = {})
      if args[:assignment_view].present?
        config = default_configs_from_args(args, domain, text, :assignment_view)
        config["visibility"] ||= "admins"
        config
      end
    end

    def self.module_menu_from_args(domain, text, args = {})
      if args[:module_menu].present?
        config["module_menu"] = args[:module_menu].stringify_keys
        if config["module_menu"]["message_type"].present?
          selection_config_from_args!(args, config, :module_menu)
        end
        default_configs_from_args(args, domain, text, :module_menu)
      end
    end

    def self.wiki_page_menu_from_args(domain, text, args = {})
      if args[:wiki_page_menu].present?
        config = default_configs_from_args(args, domain, text, :wiki_page_menu).merge(
          args[:wiki_page_menu].stringify_keys,
        )
        if args[:wiki_page_menu][:message_type].present?
          selection_config_from_args!(args, config, :wiki_page_menu)
        else
          config
        end
      end
    end

    def self.content_migration_args(_domain, _text, args = {})
      if args[:content_migration].present?
        config = args[:content_migration] || {}
        config["export_start_url"] ||= args[:export_url]
        config["import_start_url"] ||= args[:import_url]
        config
      end
    end

    def self.selection_config_from_args!(args, config, placement)
      config["placement"] = placement
      config["message_type"] ||= "ContentItemSelectionRequest"
      config["url"] ||= args[:launch_url]
      config
    end

    def self.assignment_configs_from_args!(args, config, key)
      config[key] = args[key].stringify_keys
      config[key]["url"] ||= args[:launch_url]
      # launch_height and launch_width are optional. Include them in the LTI config to set to a specific value
    end

    def self.default_configs_from_args(_args, _domain, text, placement)
      {
        "placement": placement,
        "text": text,
        "enabled": true,
        "icon_url": "https://{domain}/atomicjolt.png",
        "message_type": "LtiResourceLinkRequest",
        "target_link_uri": "https://{domain}/lti_launches",
      }
    end
  end
end
