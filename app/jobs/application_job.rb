class ApplicationJob < ActiveJob::Base
  queue_as :default

  before_perform :set_rollbar_scope

  Que.error_notifier = proc do |_error, job|
    if job[:error_count] > 17
      QueJob.find_by(job_id: job[:job_id])&.destroy
    end
  end

  private

  def set_rollbar_scope
    Rollbar.scope!(
      tenant: Apartment::Tenant.current,
    )
  end
end
