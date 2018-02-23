require "rails_helper"

describe WebpackHelper do
  before do
    @current_use_manifest = Rails.configuration.webpack[:use_manifest]
    Rails.configuration.webpack[:use_manifest] = true

    # Load manifests
    src_dir = Rails.root.join("spec", "fixtures")
    WebpackUtils.build_manifest(src_dir, :asset_manifest, "webpack-assets.json")
    WebpackUtils.build_manifest(src_dir, :common_manifest, "webpack-common-manifest.json")

    @app_name = "hello_world"
    @chunk_name = "hello_world"

    @js_src = "/assets/hello_world-39124edba8a2c33280d3_bundle.js"
    @script_tag = "<script src='#{@js_src}' type='text/javascript'></script>".html_safe

    @css_src = "/assets/hello_world-39124edba8a2c33280d3.css"
    @link_tag = "<link rel='stylesheet' href='#{@css_src}' type='text/css'>".html_safe
  end

  after do
    Rails.configuration.webpack[:use_manifest] = @current_use_manifest
  end

  describe "get_src" do
    context "use_manifest is true" do
      it "generates a javascript tag" do
        expect(helper.get_src(@app_name, @chunk_name, "js")).to eq(@js_src)
      end
      it "generates a css tag" do
        expect(helper.get_src(@app_name, @chunk_name, "css")).to eq(@css_src)
      end
      it "throws an exception when the manifest isn't found" do
        expect do
          helper.get_src("bad_app", "", "js")
        end.to raise_error(Exceptions::ManifestMissing)
      end
    end
  end

  describe "webpack_bundle_tag" do
    it "generates a script tag for the webpack bundle" do
      expect(helper.webpack_bundle_tag(@app_name, @chunk_name)).to eq(@script_tag)
    end
  end

  describe "webpack_styles_tag" do
    it "generates a style tag for the webpack bundle" do
      expect(helper.webpack_styles_tag(@app_name, @chunk_name)).to eq(@link_tag)
    end
  end

  describe "webpack_manifest_script" do
    it "generates a style tag for the webpack bundle" do
      result = "<script>
//<![CDATA[
window.webpackBundleManifest = #{Rails.configuration.webpack[:common_manifest][@app_name].to_json}
//]]>
</script>"
      expect(helper.webpack_manifest_script(@app_name)).to eq(result)
    end
  end
end
