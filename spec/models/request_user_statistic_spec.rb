require "rails_helper"

RSpec.describe RequestUserStatistic, type: :model do
  before do
    @tenant = "bfcoder"
    FactoryBot.create(
      :request_user_statistic,
      truncated_time: Time.zone.now,
      tenant: @tenant,
      user_id: 6,
    )
    FactoryBot.create(
      :request_user_statistic,
      truncated_time: Time.zone.now - 3.days,
      tenant: @tenant,
      user_id: 2,
    )
    FactoryBot.create(
      :request_user_statistic,
      truncated_time: Time.zone.now - 20.days,
      tenant: @tenant,
      user_id: 6,
    )
    FactoryBot.create(
      :request_user_statistic,
      truncated_time: Time.zone.now - 40.days,
      tenant: @tenant,
      user_id: 6,
    )
    FactoryBot.create(
      :request_user_statistic,
      truncated_time: Time.zone.now - 2.years,
      tenant: @tenant,
      user_id: 2,
    )
  end

  context "scopes" do
    describe "for_day" do
      it "should return request logs for the current day" do
        request_user_statistics = RequestUserStatistic.for_day
        expect(request_user_statistics.count).to eq(1)
      end
    end

    describe "for_week" do
      it "should return request logs for the current week" do
        request_user_statistics = RequestUserStatistic.for_week
        expect(request_user_statistics.count).to eq(2)
      end
    end

    describe "for_month" do
      it "should return request logs for the current month" do
        request_user_statistics = RequestUserStatistic.for_month
        expect(request_user_statistics.count).to eq(3)
      end
    end

    describe "for_year" do
      it "should return request logs for the year" do
        request_user_statistics = RequestUserStatistic.for_year
        expect(request_user_statistics.count).to eq(4)
      end
    end

    describe "for_tenant" do
      it "should return request logs for a given tenant" do
        FactoryBot.create(:request_user_statistic)
        request_user_statistics = RequestUserStatistic.for_tenant(@tenant)
        expect(request_user_statistics.count).to eq(5)
      end
    end

    describe "year_unique_users" do
      it "should return the unique users from a year" do
        year_unique_users = RequestUserStatistic.year_unique_users(@tenant)
        expect(year_unique_users).to eq(2)
      end
    end

    describe "max_monthly_unique_users" do
      it "should return the max unique users for a month in the year for each tenant" do
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 3.months,
          tenant: @tenant,
          user_id: 70,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 3.months,
          tenant: @tenant,
          user_id: 50,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 3.months,
          tenant: @tenant,
          user_id: 60,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 7.months,
          tenant: "atomic",
          user_id: 21,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 5.months,
          tenant: "jolt",
          user_id: 22,
        )
        tenants = [@tenant, "atomic", "jolt"]

        max_month_unique_users = RequestUserStatistic.max_month_unique_users(tenants)
        expect(max_month_unique_users["bfcoder"]).to eq(3)
        expect(max_month_unique_users["atomic"]).to eq(1)
        expect(max_month_unique_users["jolt"]).to eq(1)
      end
    end

    describe "monthly_unique_users" do
      it "should return the unique users by month for the last year" do

        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now,
          tenant: "atomic",
          user_id: 70,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now,
          tenant: "atomic",
          user_id: 50,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now,
          tenant: "atomic",
          user_id: 60,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 7.months,
          tenant: "atomic",
          user_id: 21,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 5.months,
          tenant: "jolt",
          user_id: 22,
        )
        monthly_unique_users = RequestUserStatistic.monthly_unique_users(["atomic"])
        byebug
        expect(
          monthly_unique_users.select { |unique| unique["month"].to_datetime.month === Time.now.month }[0]["user_count"],
        ).to eq(3)
      end
    end

    describe "total_unique_users" do
      it "should return all unique user counts" do
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          user_id: 70,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 14.days,
          tenant: @tenant,
          user_id: 50,
        )
        day_1_users, day_7_users, day_30_users =
          RequestUserStatistic.total_unique_users(@tenant)

        expect(day_1_users).to eq(1)
        expect(day_7_users).to eq(3)
        expect(day_30_users).to eq(4)
      end

      it "should return all unique user counts grouped" do
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          user_id: 70,
        )
        FactoryBot.create(
          :request_user_statistic,
          truncated_time: Time.zone.now - 14.days,
          tenant: @tenant,
          user_id: 50,
        )
        day_1_users_grouped, day_7_users_grouped, day_30_users_grouped =
          RequestUserStatistic.total_unique_users_grouped(@tenant, [0, 7, 30])

        expect(day_1_users_grouped[@tenant]).to eq(1)
        expect(day_7_users_grouped[@tenant]).to eq(3)
        expect(day_30_users_grouped[@tenant]).to eq(4)
      end
    end
  end
end
