class RequestStatistic < ApplicationRecord
  self.primary_keys = :truncated_time, :tenant

  scope :for_day,
        ->(date = Time.zone.now) { where(truncated_time: [date.beginning_of_day..date.end_of_day]) }
  scope :for_week,
        ->(date = Time.zone.now) { where(truncated_time: [(date.beginning_of_day - 7.days)..date.end_of_day]) }
  scope :for_month,
        ->(date = Time.zone.now) { where(truncated_time: [(date.beginning_of_day - 30.days)..date.end_of_day]) }
  scope :for_tenant, ->(tenant) { where(tenant: tenant) }

  def self.total_requests(tenant)
    day_1_requests = RequestStatistic.
      for_day.
      for_tenant(tenant).
      sum(:number_of_hits)

    day_7_requests = RequestStatistic.
      for_week.
      for_tenant(tenant).
      sum(:number_of_hits)

    day_30_requests = RequestStatistic.
      for_month.
      for_tenant(tenant).
      sum(:number_of_hits)

    [day_1_requests, day_7_requests, day_30_requests]
  end

  def self.total_requests_grouped(tenants)
    day_1_requests_grouped = RequestStatistic.
      for_day.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_hits)

    day_7_requests_grouped = RequestStatistic.
      for_week.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_hits)

    day_30_requests_grouped = RequestStatistic.
      for_month.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_hits)

    [day_1_requests_grouped, day_7_requests_grouped, day_30_requests_grouped]
  end

  def self.total_lti_launches(tenant)
    day_1_lti_launches = RequestStatistic.
      for_day.
      for_tenant(tenant).
      sum(:number_of_lti_launches)

    day_7_lti_launches = RequestStatistic.
      for_week.
      for_tenant(tenant).
      sum(:number_of_lti_launches)

    day_30_lti_launches = RequestStatistic.
      for_month.
      for_tenant(tenant).
      sum(:number_of_lti_launches)

    [day_1_lti_launches, day_7_lti_launches, day_30_lti_launches]
  end

  def self.total_lti_launches_grouped(tenants)
    day_1_lti_launches_grouped = RequestStatistic.
      for_day.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_lti_launches)

    day_7_lti_launches_grouped = RequestStatistic.
      for_week.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_lti_launches)

    day_30_lti_launches_grouped = RequestStatistic.
      for_month.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_lti_launches)

    [day_1_lti_launches_grouped, day_7_lti_launches_grouped, day_30_lti_launches_grouped]
  end

  def self.total_errors(tenant)
    day_1_number_of_errors = RequestStatistic.
      for_day.
      for_tenant(tenant).
      sum(:number_of_errors)

    day_7_number_of_errors = RequestStatistic.
      for_week.
      for_tenant(tenant).
      sum(:number_of_errors)

    day_30_number_of_errors = RequestStatistic.
      for_month.
      for_tenant(tenant).
      sum(:number_of_errors)

    [day_1_number_of_errors, day_7_number_of_errors, day_30_number_of_errors]
  end

  def self.total_errors_grouped(tenants)
    day_1_number_of_errors_grouped = RequestStatistic.
      for_day.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_errors)

    day_7_number_of_errors_grouped = RequestStatistic.
      for_week.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_errors)

    day_30_number_of_errors_grouped = RequestStatistic.
      for_month.
      for_tenant(tenants).
      group(:tenant).
      sum(:number_of_errors)

    [day_1_number_of_errors_grouped, day_7_number_of_errors_grouped, day_30_number_of_errors_grouped]
  end
end
