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

  def self.max_month_unique_users(tenants)
    tenant_count_by_month = RequestUserStatistic.
      select("tenant, DATE_TRUNC('month', truncated_time) as month, COUNT(DISTINCT(user_id)) as user_count").
      where(truncated_time: (Time.now - 1.year).beginning_of_month..Time.now.end_of_month).
      for_tenant(tenants).
      group("tenant, DATE_TRUNC('month',truncated_time)").as_json

    month_max = {}
    tenants.each do |t|
      month_max[t] = tenant_count_by_month.select { |i| i["tenant"] == t }.map { |i| i["user_count"] }.max
    end
    month_max
  end

  def self.year_unique_users(tenant)
    RequestUserStatistic.
      for_year.
      for_tenant(tenant).
      group(:user_id).
      count.
      length
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
