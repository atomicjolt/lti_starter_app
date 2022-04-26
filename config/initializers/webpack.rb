def build_manifest(src_dir, manifest_name, kind)
  Rails.configuration.webpack[manifest_name] = {}
  Dir.glob("#{src_dir}/*#{kind}") do |file|
    app_name = File.basename(file).gsub("-#{kind}", "")
    Rails.configuration.webpack[manifest_name][app_name] = JSON.parse(
      File.read(file),
    ).with_indifferent_access
  end
end

if Rails.configuration.webpack[:use_manifest]
  configs_dir = Rails.root.join("config", "assets")
  build_manifest(configs_dir, :asset_manifest, "webpack-assets.json")
  build_manifest(configs_dir, :common_manifest, "webpack-common-manifest.json")
end
