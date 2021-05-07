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

  def self.total_unique_users(tenant, list_of_days = [0, 7, 30])
    list_of_days.map do |days|
      RequestUserStatistic.
        for_n_days(days).
        for_tenant(tenant).
        group(:user_id).
        count.
        length
    end
  end

  def self.max_month_unique_users(tenants)
    tenant_count_by_month = monthly_unique_users(tenants)
    month_max = {}
    month_max = Hash.new 0
    tenant_count_by_month.each do |row|
      max = month_max[row["tenant"]]
      month_max[row["tenant"]] = [max, row["user_count"]].max
    end
    month_max
  end

  def self.monthly_unique_users(
    tenants,
    start_month = (Time.now - 1.year).beginning_of_month,
    end_month = Time.now.end_of_month
  )
    RequestUserStatistic.
      select("tenant, DATE_TRUNC('month', truncated_time) as month, COUNT(DISTINCT(user_id)) as user_count").
      where(truncated_time: start_month..end_month).
      for_tenant(tenants).
      group("tenant, DATE_TRUNC('month',truncated_time)").as_json
  end

  def self.year_unique_users(tenant)
    RequestUserStatistic.
      for_year.
      for_tenant(tenant).
      group(:user_id).
      count.
      length
  end

  def self.total_unique_users_with_roles(tenant, start_at, end_at)
    user_ids = RequestUserStatistic.
      where(truncated_time: start_at..end_at).
      for_tenant(tenant).
      group(:user_id).
      pluck(:user_id)

    not_student_count = 0
    student_count = 0
    unknown_count = 0
    Apartment::Tenant.switch tenant do
      User.includes(:roles).where(id: user_ids).each do |user|
        roles = user.roles.pluck(:name).uniq

        if roles.include?("urn:lti:instrole:ims/lis/Instructor") ||
            roles.include?("urn:lti:role:ims/lis/Instructor") ||
            roles.include?("urn:lti:instrole:ims/lis/Administrator") ||
            roles.include?("urn:lti:role:ims/lis/Mentor")
            roles.include?("urn:lti:role:ims/lis/ContentDeveloper") ||
            roles.include?("urn:lti:role:ims/lis/TeachingAssistant")
          not_student_count += 1
        elsif roles.include?("urn:lti:instrole:ims/lis/Student") ||
            roles.include?("urn:lti:role:ims/lis/Learner") ||
            roles.include?("urn:lti:role:ims/lis/Learner/NonCreditLearner")
          student_count += 1
        else
          unknown_count += 1
        end
      end
    end
    {
      total: user_ids.count,
      student_count: student_count,
      not_student_count: not_student_count,
      unknown_count: unknown_count,
    }
  end

  def self.total_unique_users_grouped(tenants, list_of_days = [365])
    list_of_days.map do |days|
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
