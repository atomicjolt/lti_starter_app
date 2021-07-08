class Api::AccountAnalyticsController < Api::ApiApplicationController
  include ApplicationHelper

  def index
    start_month = params["start_month"] || (Time.now - 1.year).beginning_of_month
    end_month = params["end_month"] || Time.now.end_of_month

    tenants = [params["tenant"]] || [Apartment::Tenant.current]

    stats = RequestUserStatistic.monthly_unique_users(tenants, start_month, end_month)
    unique_data = create_unique_data(stats, start_month, end_month)
    render json: unique_data.as_json
  end

  def create_unique_data(stats, start_month, end_month)
    data = {
      months: [],
      unique_users: [],
    }

    month_range = (end_month.year * 12 + end_month.month) - (start_month.year * 12 + start_month.month)

    Array.new(month_range) { |i| (end_month - i.month) }.each do |date|
      data[:months].push(Date::ABBR_MONTHNAMES[date.month])
      unique_search = stats.select { |stat| Time.new(stat["month"]).month == (date.month) }[0]
      data[:unique_users].push(unique_search ? unique_search["user_count"] : 0)
    end
    data
  end
end
