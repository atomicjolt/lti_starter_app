module Integrations

  class CanvasBaseLti

    def self.find_tool_id(existing_tools, tool_launch_url)
      if tool = find_tool(existing_tools, tool_launch_url)
        tool["id"]
      end
    end

    def self.find_tool(existing_tools, tool_launch_url)
      existing_tools.detect { |t| t["url"] == tool_launch_url }
    end

  end

end
