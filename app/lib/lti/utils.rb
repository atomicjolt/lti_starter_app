module Lti

  class Utils

    def self.lti_configs
      ApplicationInstance.find_each.map do |app_inst|
        if xml_config = app_inst.lti_config_xml
          puts "-------------------------------------------------------------------------------------"
          puts "LTI configuration for #{app_inst.application.name}"
          puts "Key : #{app_inst.lti_key}"
          puts "Secret : #{app_inst.lti_secret}"
          puts ""
          puts xml_config
          puts ""
          puts ""
        end
        { app: app_inst, config: xml_config }
      end
    end

  end

  def self.list_all
    ApplicationInstance.find_each do |app|
      api = LMS::Canvas.new(
        UrlHelper.scheme_host(app.site.url),
        Rails.Application.secrets.canvas_token || app.canvas_token,
      )

      puts "Course LTI Tools"
      iterate_tools(api, :course_id, "LIST_YOUR_COURSES", "COURSES") do |external_tool, parent|
        puts "#{parent['name']}: #{external_tool['name']}"
      end

      puts "Account LTI tools"
      iterate_tools(api, :account_id, "LIST_ACCOUNTS", "ACCOUNTS") do |external_tool, parent|
        puts "#{parent['name']}: #{external_tool['name']}"
      end
    end
  end

  def self.destroy_all
    ApplicationInstance.find_each do |app|
      puts "Removing LTI tool: #{app.application.name} Canvas url: #{app.site.url}"
      api = LMS::Canvas.new(
        UrlHelper.scheme_host(app.site.url),
        Rails.Application.secrets.canvas_token || app.canvas_token,
      )

      puts "Removing LTI tools from courses"
      iterate_tools(api, :course_id, "LIST_YOUR_COURSES", "COURSES") do |external_tool, parent|
        remove_tool(api, external_tool, parent, remove_tools)
      end

      puts "Removing LTI tools from accounts"
      iterate_tools(api, :account_id, "LIST_ACCOUNTS", "ACCOUNTS") do |external_tool, parent|
        remove_tool(api, external_tool, parent, remove_tools)
      end
    end
  end

  def self.iterate_tools(api, id_type, list_constant, constant)
    api.proxy(list_constant, {}, nil, true) do |results|
      results.each do |parent|
        external_tools = api.proxy(
          "LIST_EXTERNAL_TOOLS_#{constant}",
          { id_type => parent["id"] },
          nil,
          true,
        )
        external_tools.each do |external_tool|
          yield external_tool, parent
        end
      end
    end
  end

  def self.remove_tool(api, external_tool, parent, remove_tools)
    if remove_tools.include?(external_tool["name"])
      puts "Removing LTI tool: #{external_tool['name']} from #{parent['name']}"
      begin
        api.proxy(
          "DELETE_EXTERNAL_TOOL_#{constant}",
          { id_type => parent["id"], external_tool_id: external_tool["id"] },
        )
      rescue LMS::Canvas::NotFoundException
        # It's possible we're trying to delete a tool we've already deleted. Move on
      end
    end
  end

end
