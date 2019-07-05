def clean_tenants
  Apartment::Tenant.switch!
  Apartment.tenant_names.each do |name|
    Apartment::Tenant.drop(name)
  end
  ApplicationInstance.destroy_all
  Application.destroy_all
  Site.destroy_all
end
