class RequestLog < ApplicationRecord
  scope :for_day, ->(date = Time.now) { where(created_at: [date.beginning_of_day..date.end_of_day]) }
  scope :for_week, ->(date = Time.now) { where(created_at: [(date.beginning_of_day - 7.days)..date.end_of_day]) }
  scope :for_month, ->(date = Time.now) { where(created_at: [(date.beginning_of_day - 30.days)..date.end_of_day]) }
  scope :for_tenant, ->(tenant) { where(tenant: tenant) }
  scope :lti_launches, -> { where(lti_launch: true) }
  scope :errors, -> { where(error: true) }

  def self.total_requests(tenant)
    day_1_requests = RequestLog.
      for_day.
      for_tenant(tenant).
      count
    day_7_requests = RequestLog.
      for_week.
      for_tenant(tenant).
      count
    day_30_requests = RequestLog.
      for_month.
      for_tenant(tenant).
      count

    [day_1_requests, day_7_requests, day_30_requests]
  end

  def self.total_unique_users(tenant)
    day_1_users = RequestLog.
      for_day.
      for_tenant(tenant).
      group(:user_id).
      count.
      length
    day_7_users = RequestLog.
      for_week.
      for_tenant(tenant).
      group(:user_id).
      count.
      length
    day_30_users = RequestLog.
      for_month.
      for_tenant(tenant).
      group(:user_id).
      count.
      length

    [day_1_users, day_7_users, day_30_users]
  end

  def self.total_lti_launches(tenant)
    day_1_launches = RequestLog.
      for_day.
      for_tenant(tenant).
      lti_launches.
      count
    day_7_launches = RequestLog.
      for_week.
      for_tenant(tenant).
      lti_launches.
      count
    day_30_launches = RequestLog.
      for_month.
      for_tenant(tenant).
      lti_launches.
      count

    [day_1_launches, day_7_launches, day_30_launches]
  end

  def self.total_errors(tenant)
    day_1_errors = RequestLog.
      for_day.
      for_tenant(tenant).
      errors.
      count
    day_7_errors = RequestLog.
      for_week.
      for_tenant(tenant).
      errors.
      count
    day_30_errors = RequestLog.
      for_month.
      for_tenant(tenant).
      errors.
      count

    [day_1_errors, day_7_errors, day_30_errors]
  end
end
