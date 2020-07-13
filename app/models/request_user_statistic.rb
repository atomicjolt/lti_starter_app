class RequestUserStatistic < ApplicationRecord
  self.primary_keys = :truncated_time, :tenant, :user_id

  scope :for_n_days, ->(num_days, date = Time.zone.now) do
    where(truncated_time: [(date.beginning_of_day - num_days.days)..date.end_of_day])
  end

  scope :for_day, ->(date = Time.zone.now) { for_n_days(0, date) }
  scope :for_week, ->(date = Time.zone.now) { for_n_days(7, date) }
  scope :for_month, ->(date = Time.zone.now) { for_n_days(30, date) }
  scope :for_year, ->(date = Time.zone.now) { for_n_days(365, date) }

  scope :for_tenant, ->(tenant) { where(tenant: tenant) }

  def self.total_unique_users(tenant)
    [0, 7, 30].map do |days|
      RequestUserStatistic.
        for_n_days(days).
        for_tenant(tenant).
        group(:user_id).
        count.
        length
    end
  end

  def self.total_unique_users_grouped(tenants)
    [0, 7, 30, 365].map do |days|
      RequestUserStatistic.
        select(:tenant, "count(*)").
        from(
          RequestUserStatistic.
          for_n_days(days).
          for_tenant(tenants).
          select(:tenant, :user_id).
          distinct,
        ).
        group(:tenant).
        map { |log| [log.tenant, log.count] }.to_h
    end
  end
end
