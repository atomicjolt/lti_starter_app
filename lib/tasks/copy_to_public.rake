namespace :copy_to_public do
  desc "Copy LtiLaunch to public"
  task lti_launch: :environment do
    Apartment.tenant_names.each do |tenant|
      Apartment::Tenant.switch(tenant) do
        puts "#{tenant}: #{LtiLaunch.count}"
        if LtiLaunch.count > 0
          puts "Working on #{tenant}"
          i = 0
          n = LtiLaunch.count
          LtiLaunch.find_each do |lti_launch|
            Apartment::Tenant.switch("public") do
              if !LtiLaunch.find_by(token: lti_launch.token, context_id: lti_launch.context_id)
                puts "Creating LtiLaunch for token: #{lti_launch.token}, context_id: #{lti_launch.context_id}"
                LtiLaunch.create(
                  token: lti_launch.token,
                  context_id: lti_launch.context_id,
                  tool_consumer_instance_guid: lti_launch.tool_consumer_instance_guid,
                  config: lti_launch.config,
                )
              end
            end
            i += 1
            printf "\r  #{i}/#{n}"
          end
        end

        puts
        puts "     DONE"
      end
    end
    puts "COMPLETED"
  end
end
