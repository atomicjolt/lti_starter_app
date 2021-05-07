class RequestStatistic < ApplicationRecord
  self.primary_keys = :truncated_time, :tenant

  scope :for_n_days, ->(num_days, date = Time.zone.now) do
    where(truncated_time: [(date.beginning_of_day - num_days.days)..date.end_of_day])
  end

  scope :for_day, ->(date = Time.zone.now) { for_n_days(0, date) }
  scope :for_week, ->(date = Time.zone.now) { for_n_days(7, date) }
  scope :for_month, ->(date = Time.zone.now) { for_n_days(30, date) }
  scope :for_year, ->(date = Time.zone.now) { for_n_days(365, date) }

  scope :for_tenant, ->(tenant) { where(tenant: tenant) }

  def self.total_requests(tenant, list_of_days = [0, 7, 30])
    list_of_days.map do |days|
      RequestStatistic.
        for_n_days(days).
        for_tenant(tenant).
        sum(:number_of_hits)
    end
  end

  def self.total_requests_grouped(tenants, list_of_days = [0, 7, 30, 365])
    list_of_days.map do |days|
      RequestStatistic.
        for_n_days(days).
        for_tenant(tenants).
        group(:tenant).
        sum(:number_of_hits)
    end
  end

  def self.total_lti_launches(tenant, list_of_days = [0, 7, 30])
    list_of_days.map do |days|
      RequestStatistic.
        for_n_days(days).
        for_tenant(tenant).
        sum(:number_of_lti_launches)
    end
  end

  def self.total_lti_launches_grouped(tenants, list_of_days = [0, 7, 30, 365])
    list_of_days.map do |days|
      RequestStatistic.
        for_n_days(days).
        for_tenant(tenants).
        group(:tenant).
        sum(:number_of_lti_launches)
    end
  end

  def self.total_errors(tenant, list_of_days = [0, 7, 30])
    list_of_days.map do |days|
      RequestStatistic.
        for_n_days(days).
        for_tenant(tenant).
        sum(:number_of_errors)
    end
  end

  def self.total_errors_grouped(tenants, list_of_days = [0, 7])
    list_of_days.map do |days|
      RequestStatistic.
        for_n_days(days).
        for_tenant(tenants).
        group(:tenant).
        sum(:number_of_errors)
    end
  end
end
