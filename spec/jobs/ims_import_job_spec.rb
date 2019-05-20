require "rails_helper"

RSpec.describe ImsImportJob, type: :job do
  subject { ImsImportJob }

  let(:ims_import) { FactoryBot.create(:ims_import) }

  let(:data) do
    {
      ims_import_id: ims_import.id,
      lti_launches: lti_launches,
      context_id: context_id,
      tool_consumer_instance_guid: tool_consumer_instance_guid,
    }
  end

  let(:lti_launches) do
    [
      {
        token: "dgqgRSCUGdkmmKMAC3Ma2nei",
        config: {
          "isTopNavigator" => "true",
        },
        context_id: "3155b3a04eba69bc0e52b987d3ffc465156daded",
        tool_consumer_instance_guid: nil,
      },
    ]
  end

  let(:context_id) { "a07201ea2fa1314729ed8bf0175a336d1eebe053" }

  let(:tool_consumer_instance_guid) { "7MRcxnx6vQbFXxhLb8003m5WXFM2Z2i9lQwhJ1QT:canvas-lms" }

  context "lti launches" do
    it "are created" do
      expect do
        subject.perform_now(data.to_json)
      end.to change(LtiLaunch, :count).by(1)
    end

    it "handles importing the same package multiple times" do
      expect do
        subject.perform_now(data.to_json)
        subject.perform_now(data.to_json)
      end.to change(LtiLaunch, :count).by(1)
    end
  end

  context "import status" do
    it "finishes" do
      subject.perform_now(data.to_json)
      expect(ims_import.reload.status).to eq "finished"
    end
  end
end
