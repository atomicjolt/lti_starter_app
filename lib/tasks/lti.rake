namespace :lti do
  # Run this task from a background process to remove all values from the nonces table.
  desc "Remove old nonces from the database"
  task :clean do
    Nonce.clean
  end

  desc "Get basic LTI configuration for all installed LTI applications."
  task configs: :environment do |_t|
    Lti::Utils.lti_configs
  end

  desc "Generate LTI test params. Call using: rake lti_test_params['lti_launch_url']"
  task :test_params, [:lti_launch_url] => :environment do |_t, args|
    require File.join(File.dirname(__FILE__), "../../spec/support/lti.rb")
    url = args[:code] || "https://www.example.com/lti/launch"

    puts "LTI key: #{oauth_consumer_key}"
    puts "LTI secret: #{oauth_consumer_secret}"
    puts "--------------------------------------"
    puts lti_params({ "launch_url" => url }).to_json
  end

  desc "Remove all installs of the LTI tools"
  task destroy_all: :environment do |_t|
    Lti::Utils.destroy_all
  end

  desc "List all installed LTI tools"
  task list_all: :environment do |_t|
    Lti::Utils.list_all
  end

  desc "Migrate lti_launches to global schema"
  task migrate_lti_launches_to_global: :environment do |_t|
    # Derived projects may have added their own columns to this table, so
    # dynamically generate the list of columns to copy.
    columns = (LtiLaunch.column_names - ["id", "application_instance_id"]).join(",")
    ApplicationInstance.all.each do |application_instance|
      tenant = application_instance.tenant
      Apartment::Tenant.switch(tenant) do
        puts "Migrating records in #{tenant}"
        connection = ActiveRecord::Base.connection
        LtiLaunch.transaction do
          connection.execute(%{
            INSERT INTO public.lti_launches (#{columns}, application_instance_id)
            SELECT #{columns}, #{application_instance.id} AS application_instance_id
              FROM "#{tenant}".lti_launches
          })
          connection.execute(%{DELETE FROM "#{tenant}".lti_launches})
        end
      end
    end
  end

  desc "Undo migrate of lti_launches to global schema"
  task rollback_lti_launches_to_global: :environment do |_t|
    # Derived projects may have added their own columns to this table, so
    # dynamically generate the list of columns to copy.
    columns = (LtiLaunch.column_names - ["id", "application_instance_id"]).join(",")
    ApplicationInstance.all.each do |application_instance|
      tenant = application_instance.tenant
      Apartment::Tenant.switch(tenant) do
        puts "Migrating records in #{tenant}"
        connection = ActiveRecord::Base.connection
        LtiLaunch.transaction do
          connection.execute(%{
            INSERT INTO "#{tenant}".lti_launches (#{columns})
            SELECT #{columns}
              FROM public.lti_launches
              WHERE application_instance_id = #{application_instance.id}
          })
          connection.execute(%{DELETE FROM public.lti_launches WHERE application_instance_id = #{application_instance.id}})
        end
      end
    end
  end
end
