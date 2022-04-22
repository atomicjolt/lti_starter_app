# Usage: rake "canvas:configure_legacy_lti[atomicjolt-atomicjournals,5251,21083]"

namespace :canvas do
    desc "List application instances"
    task :application_instances_by_site, [:site_url] => :environment do |_t, args|
      lti_keys_for_site = Site.find_by(url: args[:site_url]).application_instances.map { |ai| {application: ai.application.name, lti_key: ai.lti_key}}
      pp lti_keys_for_site
    end

    desc "List canvas course tools"
    task :list_course_tools, [:lti_key, :course_id] => :environment do |_t, args|
      course_id = args[:course_id]
      lti_key = args[:lti_key]
      current_application_instance = ApplicationInstance.find_by!(lti_key: lti_key)

      raise "No canvas token set on application instance!" if current_application_instance.canvas_token.nil?

      api = LMS::Canvas.new(current_application_instance.site.url, current_application_instance.canvas_token)

      external_tools = api.proxy("LIST_EXTERNAL_TOOLS_COURSES", { course_id: course_id })
      pp external_tools
    end

    desc "Configure canvas external tool lti consumer key and shared secret from application instance"
    task :configure_legacy_lti, [:lti_key, :course_id, :tool_id] => :environment do |_t, args|
      course_id = args[:course_id]
      lti_key = args[:lti_key]
      current_application_instance = ApplicationInstance.find_by!(lti_key: lti_key)
      raise "No canvas token set on application instance!" if current_application_instance.canvas_token.nil?

      api = LMS::Canvas.new(current_application_instance.site.url, current_application_instance.canvas_token)

      result = api.proxy(
        "EDIT_EXTERNAL_TOOL_COURSES",
        {
          course_id: course_id,
          external_tool_id: args[:tool_id],
        },
        {
          consumer_key: current_application_instance.lti_key,
          shared_secret: current_application_instance.lti_secret,
        },
      )
      pp result
    end
  end