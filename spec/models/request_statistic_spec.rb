require "rails_helper"

RSpec.describe RequestStatistic, type: :model do
  before do
    @tenant = "bfcoder"
    FactoryBot.create(
      :request_statistic,
      truncated_time: Time.zone.now,
      tenant: @tenant,
      number_of_hits: 10,
      number_of_lti_launches: 5,
      number_of_errors: 2,
    )
    FactoryBot.create(
      :request_statistic,
      truncated_time: Time.zone.now - 3.days,
      tenant: @tenant,
      number_of_hits: 100,
      number_of_lti_launches: 50,
      number_of_errors: 20,
    )
    FactoryBot.create(
      :request_statistic,
      truncated_time: Time.zone.now - 20.days,
      tenant: @tenant,
      number_of_hits: 1000,
      number_of_lti_launches: 500,
      number_of_errors: 200,
    )
    FactoryBot.create(
      :request_statistic,
      truncated_time: Time.zone.now - 40.days,
      tenant: @tenant,
      number_of_hits: 1000,
      number_of_lti_launches: 500,
      number_of_errors: 200,
    )
  end

  context "scopes" do
    describe "for_day" do
      it "should return request logs for the current day" do
        request_statistics = RequestStatistic.for_day
        expect(request_statistics.count).to eq(1)
      end
    end

    describe "for_week" do
      it "should return request logs for the current week" do
        request_statistics = RequestStatistic.for_week
        expect(request_statistics.count).to eq(2)
      end
    end

    describe "for_month" do
      it "should return request logs for the current month" do
        request_statistics = RequestStatistic.for_month
        expect(request_statistics.count).to eq(3)
      end
    end

    describe "for_tenant" do
      it "should return request logs for a given tenant" do
        FactoryBot.create(:request_statistic)
        request_statistics = RequestStatistic.for_tenant(@tenant)
        expect(request_statistics.count).to eq(4)
      end
    end

    describe "total_requests" do
      it "should return requests count for the tenant" do
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          number_of_hits: 200,
          number_of_lti_launches: 100,
          number_of_errors: 30,
        )
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 10.days,
          tenant: @tenant,
          number_of_hits: 1000,
          number_of_lti_launches: 500,
          number_of_errors: 200,
        )
        day_1_requests, day_7_requests, day_30_requests =
          RequestStatistic.total_requests(@tenant)

        expect(day_1_requests).to eq(10)
        expect(day_7_requests).to eq(310)
        expect(day_30_requests).to eq(2310)
      end

      it "should return the requests grouped by tenant" do
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          number_of_hits: 200,
          number_of_lti_launches: 100,
          number_of_errors: 30,
        )
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 10.days,
          tenant: @tenant,
          number_of_hits: 1000,
          number_of_lti_launches: 500,
          number_of_errors: 200,
        )

        day_1_requests_grouped, day_7_requests_grouped, day_30_requests_grouped =
          RequestStatistic.total_requests_grouped(RequestStatistic.all.pluck(:tenant).uniq)

        expect(day_1_requests_grouped[@tenant]).to eq(10)
        expect(day_7_requests_grouped[@tenant]).to eq(310)
        expect(day_30_requests_grouped[@tenant]).to eq(2310)
      end
    end

    describe "total_lti_launches" do
      it "should return total lti launches counts" do
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          number_of_hits: 200,
          number_of_lti_launches: 100,
          number_of_errors: 30,
        )
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 10.days,
          tenant: @tenant,
          number_of_hits: 1000,
          number_of_lti_launches: 500,
          number_of_errors: 200,
        )
        day_1_launches, day_7_launches, day_30_launches =
          RequestStatistic.total_lti_launches(@tenant)

        expect(day_1_launches).to eq(5)
        expect(day_7_launches).to eq(155)
        expect(day_30_launches).to eq(1155)
      end

      it "should return total lti launches counts grouped" do
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          number_of_hits: 200,
          number_of_lti_launches: 100,
          number_of_errors: 30,
        )
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 10.days,
          tenant: @tenant,
          number_of_hits: 1000,
          number_of_lti_launches: 500,
          number_of_errors: 200,
        )
        day_1_launches_grouped, day_7_launches_grouped, day_30_launches_grouped =
          RequestStatistic.total_lti_launches_grouped(@tenant)

        expect(day_1_launches_grouped[@tenant]).to eq(5)
        expect(day_7_launches_grouped[@tenant]).to eq(155)
        expect(day_30_launches_grouped[@tenant]).to eq(1155)
      end
    end

    describe "total_errors" do
      it "should return total errors counts" do
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          number_of_hits: 200,
          number_of_lti_launches: 100,
          number_of_errors: 30,
        )
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 10.days,
          tenant: @tenant,
          number_of_hits: 1000,
          number_of_lti_launches: 500,
          number_of_errors: 200,
        )
        day_1_errors, day_7_errors, day_30_errors =
          RequestStatistic.total_errors(@tenant)

        expect(day_1_errors).to eq(2)
        expect(day_7_errors).to eq(52)
        expect(day_30_errors).to eq(452)
      end

      it "should return total errors counts grouped" do
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 2.days,
          tenant: @tenant,
          number_of_hits: 200,
          number_of_lti_launches: 100,
          number_of_errors: 30,
        )
        FactoryBot.create(
          :request_statistic,
          truncated_time: Time.zone.now - 10.days,
          tenant: @tenant,
          number_of_hits: 1000,
          number_of_lti_launches: 500,
          number_of_errors: 200,
        )
        day_1_errors_grouped, day_7_errors_grouped, day_30_errors_grouped =
          RequestStatistic.total_errors_grouped(@tenant, [0, 7, 30])

        expect(day_1_errors_grouped[@tenant]).to eq(2)
        expect(day_7_errors_grouped[@tenant]).to eq(52)
        expect(day_30_errors_grouped[@tenant]).to eq(452)
      end
    end
  end
end
