class RequestUserStatistic < ApplicationRecord
  self.primary_keys = :truncated_time, :tenant, :user_id

  scope :for_day, ->(date = Time.zone.now) { where(truncated_time: [date.beginning_of_day..date.end_of_day]) }
  scope :for_week, ->(date = Time.zone.now) { where(truncated_time: [(date.beginning_of_day - 7.days)..date.end_of_day]) }
  scope :for_month, ->(date = Time.zone.now) { where(truncated_time: [(date.beginning_of_day - 30.days)..date.end_of_day]) }
  scope :for_tenant, ->(tenant) { where(tenant: tenant) }

  def self.total_unique_users(tenant)
    day_1_users = RequestUserStatistic.
      for_day.
      for_tenant(tenant).
      group(:user_id).
      count.
      length

    day_7_users = RequestUserStatistic.
      for_week.
      for_tenant(tenant).
      group(:user_id).
      count.
      length

    day_30_users = RequestUserStatistic.
      for_month.
      for_tenant(tenant).
      group(:user_id).
      count.
      length

    [day_1_users, day_7_users, day_30_users]
  end

  def self.total_unique_users_grouped(tenants)
    day_1_users_grouped = RequestUserStatistic.
      select(:tenant, "count(*)").
      from(
        RequestUserStatistic.
        for_day.
        for_tenant(tenants).
        group(:tenant, :user_id).
        select(:tenant),
      ).
      group(:tenant).
      map { |log| [log.tenant, log.count] }

    day_7_users_grouped = RequestUserStatistic.
      select(:tenant, "count(*)").
      from(
        RequestUserStatistic.
        for_week.
        for_tenant(tenants).
        group(:tenant, :user_id).
        select(:tenant),
      ).
      group(:tenant).
      map { |log| [log.tenant, log.count] }

    day_30_users_grouped = RequestUserStatistic.
      select(:tenant, "count(*)").
      from(
        RequestUserStatistic.
        for_month.
        for_tenant(tenants).
        group(:tenant, :user_id).
        select(:tenant),
      ).
      group(:tenant).
      map { |log| [log.tenant, log.count] }

    [Hash[day_1_users_grouped], Hash[day_7_users_grouped], Hash[day_30_users_grouped]]
  end
end
