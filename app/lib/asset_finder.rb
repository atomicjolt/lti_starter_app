module AssetFinder
  def self.get_src(file_name, asset_host = nil)
    # Normally a rails helper could be used here, but these assets are
    # deliberately left out of the asset pipeline so their names don't get
    # digested
    src = "/assets/#{file_name}"

    asset_host ||= Rails.configuration.action_controller.asset_host
    if asset_host.present?
      src = URI::join(asset_host, src).to_s
    end

    src
  end
end
