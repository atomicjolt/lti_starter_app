module Localization
  # Map from LTI launch locale to app and client locale
  LOCALES = {
    "en" => "en",
  }.freeze

  # Return a valid locale or nil, if none
  def self.get_locale(locale)
    return nil if locale.blank?

    short_locale = locale.split("-")[0]
    if LOCALES[locale]
      LOCALES[locale]
    elsif LOCALES[short_locale]
      LOCALES[short_locale]
    else
      nil
    end
  end

  # Return a fallback locale based on the application instance
  def self.get_default_locale(application_instance)
    instance_locale = application_instance.get_config(:language)
    get_locale(instance_locale) || "en"
  end
end
