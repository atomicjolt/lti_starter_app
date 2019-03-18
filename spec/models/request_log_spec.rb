require "rails_helper"

RSpec.describe RequestLog, type: :model do
  before do
    @tenant = "bfcoder"
    @day_requests = Array.new(2).map do
      FactoryBot.create(
        :request_log,
        tenant: @tenant,
        user_id: "1",
        lti_launch: false,
        error: false,
      )
    end
    @week_requests = Array.new(3).map do
      FactoryBot.create(
        :request_log,
        created_at: Time.now - 3.days,
        user_id: "2",
        lti_launch: true,
        error: false,
      )
    end
    @month_requests = Array.new(4).map do
      FactoryBot.create(
        :request_log,
        created_at: Time.now - 20.days,
        user_id: "3",
        lti_launch: false,
        error: true,
      )
    end
  end

  context "scopes" do
    describe "for_day" do
      it "should return request logs for the current day" do
        request_logs = RequestLog.for_day
        expect(request_logs.count).to eq(2)
      end
    end

    describe "for_week" do
      it "should return request logs for the current day" do
        request_logs = RequestLog.for_week
        expect(request_logs.count).to eq(5)
      end
    end

    describe "for_month" do
      it "should return request logs for the current day" do
        request_logs = RequestLog.for_month
        expect(request_logs.count).to eq(9)
      end
    end

    describe "for_tenant" do
      it "should return request logs for the current day" do
        request_logs = RequestLog.for_tenant(@tenant)
        expect(request_logs.count).to eq(2)
      end
    end

    describe "lti_launches" do
      it "should return request logs for the current day" do
        request_logs = RequestLog.lti_launches
        expect(request_logs.count).to eq(3)
      end
    end

    describe "errors" do
      it "should return request logs for the current day" do
        request_logs = RequestLog.errors
        expect(request_logs.count).to eq(4)
      end
    end

    describe "total_requests" do
      it "should return requests count for the tenant" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          lti_launch: true,
          error: false,
        )
        day_1_requests, day_7_requests, day_30_requests =
          RequestLog.total_requests(@tenant)

        expect(day_1_requests).to eq(2)
        expect(day_7_requests).to eq(2)
        expect(day_30_requests).to eq(3)
      end

      it "should return the requests grouped by tenant" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          lti_launch: true,
          error: false,
        )
        day_1_requests_grouped, day_7_requests_grouped, day_30_requests_grouped =
          RequestLog.total_requests_grouped(RequestLog.all.pluck(:tenant).uniq)

        expect(day_1_requests_grouped[@tenant]).to eq(2)
        expect(day_7_requests_grouped[@tenant]).to eq(2)
        expect(day_30_requests_grouped[@tenant]).to eq(3)
      end

      it "should return all unique user counts" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 3.days,
          tenant: @tenant,
          user_id: "2",
          lti_launch: true,
          error: false,
        )
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          user_id: "3",
          lti_launch: true,
          error: false,
        )
        day_1_users, day_7_users, day_30_users =
          RequestLog.total_unique_users(@tenant)

        expect(day_1_users).to eq(1)
        expect(day_7_users).to eq(2)
        expect(day_30_users).to eq(3)
      end

      it "should return all unique user counts grouped" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 3.days,
          tenant: @tenant,
          user_id: "2",
          lti_launch: true,
          error: false,
        )
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          user_id: "3",
          lti_launch: true,
          error: false,
        )
        day_1_users_grouped, day_7_users_grouped, day_30_users_grouped =
          RequestLog.total_unique_users_grouped(@tenant)

        expect(day_1_users_grouped[@tenant]).to eq(1)
        expect(day_7_users_grouped[@tenant]).to eq(2)
        expect(day_30_users_grouped[@tenant]).to eq(3)
      end

      it "should return total lti launches counts" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 3.days,
          tenant: @tenant,
          user_id: "2",
          lti_launch: true,
          error: false,
        )
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          user_id: "3",
          lti_launch: false,
          error: false,
        )
        day_1_launches, day_7_launches, day_30_launches =
          RequestLog.total_lti_launches(@tenant)

        expect(day_1_launches).to eq(0)
        expect(day_7_launches).to eq(1)
        expect(day_30_launches).to eq(1)
      end

      it "should return total lti launches counts grouped" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 3.days,
          tenant: @tenant,
          user_id: "2",
          lti_launch: true,
          error: false,
        )
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          user_id: "3",
          lti_launch: false,
          error: false,
        )
        day_1_launches_grouped, day_7_launches_grouped, day_30_launches_grouped =
          RequestLog.total_lti_launches_grouped(@tenant)

        expect(day_1_launches_grouped[@tenant]).to eq(nil)
        expect(day_7_launches_grouped[@tenant]).to eq(1)
        expect(day_30_launches_grouped[@tenant]).to eq(1)
      end

      it "should return total errors counts" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 3.days,
          tenant: @tenant,
          user_id: "2",
          lti_launch: true,
          error: false,
        )
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          user_id: "3",
          lti_launch: false,
          error: true,
        )
        day_1_errors, day_7_errors, day_30_errors =
          RequestLog.total_errors(@tenant)

        expect(day_1_errors).to eq(0)
        expect(day_7_errors).to eq(0)
        expect(day_30_errors).to eq(1)
      end

      it "should return total errors counts grouped" do
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 3.days,
          tenant: @tenant,
          user_id: "2",
          lti_launch: true,
          error: false,
        )
        FactoryBot.create(
          :request_log,
          created_at: Time.now - 20.days,
          tenant: @tenant,
          user_id: "3",
          lti_launch: false,
          error: true,
        )
        day_1_errors_grouped, day_7_errors_grouped, day_30_errors_grouped =
          RequestLog.total_errors_grouped(@tenant)

        expect(day_1_errors_grouped[@tenant]).to eq(nil)
        expect(day_7_errors_grouped[@tenant]).to eq(nil)
        expect(day_30_errors_grouped[@tenant]).to eq(1)
      end
    end
  end
end
