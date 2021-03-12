require "apartment/active_job"

class ActiveJob::Base
  include Apartment::ActiveJob
end
