require "rails_helper"

RSpec.describe ImsExportJob, type: :job do
  include ActiveJob::TestHelper

  before do
    setup_application_instance
  end

  after do
    clear_enqueued_jobs
  end

  subject { ImsExportJob }

  let(:export) { create(:ims_export, payload: { lti_launches: [] }) }

  let(:ims_export_params) do
    {
      context_id: "123",
      tool_consumer_instance_guid: "abc",
      custom_canvas_course_id: "1331",
    }
  end

  let(:lti_launch) { create(:lti_launch, context_id: "123") }

  it "Collects the lti launches" do
    expect(export.payload["lti_launches"]).to_not include(lti_launch)
    subject.perform_now(export, @application_instance, ims_export_params.to_json)
    expect(export.payload["lti_launches"].count).to eq(1)
    ll = export.payload["lti_launches"].first
    expect(ll["token"]).to include(lti_launch.token)
  end

  it "Updates the status" do
    expect do
      subject.perform_now(export, @application_instance, ims_export_params.to_json)
    end.to change(export, :status).to(ImsExport::COMPLETED)
  end
end
