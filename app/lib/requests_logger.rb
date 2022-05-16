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
    user_id = if warden_session
                warden_session[0][0]
              else
                0
              end
    lti_launch = request.path.match?(/^\/lti_launches/) ? 1 : 0
    error = @status.to_s.match?(/^5/) ? 1 : 0

    time_type = ActiveModel::Type::Time.new
    int_type = ActiveModel::Type::Integer.new limit: 4
    big_int_type = ActiveModel::Type::BigInteger.new
    str_type = ActiveModel::Type::String.new

    request_binds = [
      ActiveRecord::Relation::QueryAttribute.new("truncated_time", current_hour, time_type),
      ActiveRecord::Relation::QueryAttribute.new("tenant", tenant, str_type),
      ActiveRecord::Relation::QueryAttribute.new("number_of_lti_launches", lti_launch, int_type),
      ActiveRecord::Relation::QueryAttribute.new("number_of_errors", error, int_type),
    ]
    user_binds = [
      ActiveRecord::Relation::QueryAttribute.new("truncated_time", current_hour, time_type),
      ActiveRecord::Relation::QueryAttribute.new("tenant", tenant, str_type),
      ActiveRecord::Relation::QueryAttribute.new("user_id", user_id, big_int_type),
    ]

    ActiveRecord::Base.connection.exec_query(
      request_statistics_sql,
      "SQL",
      request_binds,
    )
    ActiveRecord::Base.connection.exec_query(
      request_user_statistics_sql,
      "SQL",
      user_binds,
    )

    [@status, @headers, @response]
  end

  def request_statistics_sql
    <<-SQL
      INSERT INTO "public"."request_statistics" ("truncated_time", "tenant", "number_of_hits", "number_of_lti_launches", "number_of_errors")
      VALUES ($1, $2, 1, $3, $4)
      ON CONFLICT ("truncated_time", "tenant")
      DO UPDATE SET
        number_of_hits = "public"."request_statistics"."number_of_hits" + 1,
        number_of_lti_launches = "public"."request_statistics"."number_of_lti_launches" + $3,
        number_of_errors = "public"."request_statistics"."number_of_errors" + $4
    SQL
  end

  def request_user_statistics_sql
    <<-SQL
      INSERT INTO "public"."request_user_statistics" ("truncated_time", "tenant", "user_id")
      VALUES ($1, $2, $3)
      ON CONFLICT ("truncated_time", "tenant", "user_id")
      DO NOTHING
    SQL
  end
end
