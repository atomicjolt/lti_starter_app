class RequestsLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)

    request = Rack::Request.new(env)

    current_hour = Time.zone.now.beginning_of_hour
    tenant = Apartment::Tenant.current
    warden_session = request.session["warden.user.user.key"]
    user_id = warden_session[0][0] if warden_session
    lti_launch = request.path == "/lti_launches" ? 1 : 0
    error = @status.to_s.match?(/^5/) ? 1 : 0

    ActiveRecord::Base.connection.exec_query(
      request_statistics_sql(
        current_hour,
        tenant,
        lti_launch,
        error,
      ),
    )
    ActiveRecord::Base.connection.exec_query(
      request_user_statistics_sql(
        current_hour,
        tenant,
        user_id,
      ),
    )

    [@status, @headers, @response]
  end

  def request_statistics_sql(truncated_time, tenant, lti_launch, error)
    <<-SQL
      INSERT INTO "public"."request_statistics" ("truncated_time", "tenant", "number_of_hits", "number_of_lti_launches", "number_of_errors")
      VALUES ('#{truncated_time}', #{ActiveRecord::Base.connection.quote(tenant)}, 1, #{lti_launch}, #{error})
      ON CONFLICT ("truncated_time", "tenant")
      DO UPDATE SET
        number_of_hits = "public"."request_statistics"."number_of_hits" + 1,
        number_of_lti_launches = "public"."request_statistics"."number_of_lti_launches" + #{lti_launch},
        number_of_errors = "public"."request_statistics"."number_of_errors" + #{error}
    SQL
  end

  def request_user_statistics_sql(truncated_time, tenant, user_id)
    <<-SQL
      INSERT INTO "public"."request_user_statistics" ("truncated_time", "tenant", "user_id")
      VALUES ('#{truncated_time}', #{ActiveRecord::Base.connection.quote(tenant)}, #{user_id})
      ON CONFLICT ("truncated_time", "tenant", "user_id")
      DO NOTHING
    SQL
  end
end
