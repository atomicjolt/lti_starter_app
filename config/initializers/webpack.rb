if Rails.configuration.webpack[:use_manifest]
  configs_dir = Rails.root.join("config", "assets")
  WebpackUtils.build_manifest(configs_dir, :asset_manifest, "webpack-assets.json")
  WebpackUtils.build_manifest(configs_dir, :common_manifest, "webpack-common-manifest.json")
end
