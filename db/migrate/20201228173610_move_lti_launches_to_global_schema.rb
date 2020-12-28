# Migrate all data from tenant-specific lti_launches tables to the global table.
# We add the applciation_instance_id to ensure uniqueness of the data in the public
# table.

class MoveLtiLaunchesToGlobalSchema < ActiveRecord::Migration[5.2]
  def lti_launches_columns
    # Derived projects may have added their own columns to this table, so
    # dynamically generate the list of columns to copy.
    columns = (LtiLaunch.column_names - ['id', 'tenant']).join(',')
  end

  def up
    columns = lti_launches_columns
    tenants = []
    ApplicationInstance.find_each do |application_instance|
      tenant = application_instance.tenant
      next if tenants.include? tenant

      tenants << tenant
      execute(%{
        INSERT INTO public.lti_launches (#{columns},tenant)
        SELECT #{columns},'#{tenant}' AS tenant
          FROM "#{tenant}".lti_launches
      })
      execute(%{DELETE FROM "#{tenant}".lti_launches})
    end
  end

  def down
    columns = lti_launches_columns
    tenants = []
    ApplicationInstance.find_each do |application_instance|
      tenant = application_instance.tenant
      next if tenants.include? tenant

      tenants << tenant
      execute(%{
        INSERT INTO "#{tenant}".lti_launches (#{columns})
        SELECT #{columns}
          FROM public.lti_launches
          WHERE tenant = '#{tenant}'
      })
      execute(%{DELETE FROM "#{tenant}".lti_launches WHERE tenant = '#{tenant}'})
    end
  end
end
