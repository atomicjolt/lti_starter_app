class QueJob < ActiveRecord::Base
  self.primary_keys = :queue, :priority, :run_at, :job_id
end
