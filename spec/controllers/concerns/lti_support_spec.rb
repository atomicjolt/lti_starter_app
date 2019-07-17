require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    setup_application_instance
    @launch_url = "http://test.host/anonymous" # url when posting to anonymous controller created below.
    allow(controller).to receive(:current_application_instance).and_return(@application_instance)
    allow(Application).to receive(:find_by).with(:lti_key).and_return(@application_instance)
  end

  controller do
    include Concerns::LtiSupport

    skip_before_action :verify_authenticity_token
    before_action :do_lti

    def index
      render plain: "User: #{current_user.display_name}"
    end
  end

  describe "LTI" do
    before do
      request.env["CONTENT_TYPE"] = "application/x-www-form-urlencoded"
    end

    context "valid LTI Advantage request" do
      before do
        iss = "https://canvas.instructure.com"
        @application_instance.application.lti_installs.create!(
          iss: iss,
          client_id: "43460000000000194",
          jwks_url: LtiAdvantage::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL,
          token_url: LtiAdvantage::Definitions::CANVAS_AUTH_TOKEN_URL,
          oidc_url: LtiAdvantage::Definitions::CANVAS_OIDC_URL,
        )
        @lti_user_id = "cfca15d8-2958-4647-a33e-a7c4b2ddab2c"
        @context_id = "af9b5e18fe251409be18e77253d918dcf22d156e"
        @params = {
          "id_token" => "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjIwMTktMDYtMDFUMDA6MDA6MDBaIn0.eyJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9tZXNzYWdlX3R5cGUiOiJMdGlSZXNvdXJjZUxpbmtSZXF1ZXN0IiwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vdmVyc2lvbiI6IjEuMy4wIiwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vcmVzb3VyY2VfbGluayI6eyJpZCI6ImFmOWI1ZTE4ZmUyNTE0MDliZTE4ZTc3MjUzZDkxOGRjZjIyZDE1NmUiLCJkZXNjcmlwdGlvbiI6bnVsbCwidGl0bGUiOm51bGwsInZhbGlkYXRpb25fY29udGV4dCI6bnVsbCwiZXJyb3JzIjp7ImVycm9ycyI6e319fSwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGktYWdzL2NsYWltL2VuZHBvaW50Ijp7InNjb3BlIjpbImh0dHBzOi8vcHVybC5pbXNnbG9iYWwub3JnL3NwZWMvbHRpLWFncy9zY29wZS9saW5laXRlbSIsImh0dHBzOi8vcHVybC5pbXNnbG9iYWwub3JnL3NwZWMvbHRpLWFncy9zY29wZS9yZXN1bHQucmVhZG9ubHkiLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS1hZ3Mvc2NvcGUvc2NvcmUiLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS1hZ3Mvc2NvcGUvbGluZWl0ZW0ucmVhZG9ubHkiXSwibGluZWl0ZW1zIjoiaHR0cHM6Ly9hdG9taWNqb2x0Lmluc3RydWN0dXJlLmNvbS9hcGkvbHRpL2NvdXJzZXMvMzMzNC9saW5lX2l0ZW1zIiwidmFsaWRhdGlvbl9jb250ZXh0IjpudWxsLCJlcnJvcnMiOnsiZXJyb3JzIjp7fX19LCJhdWQiOiI0MzQ2MDAwMDAwMDAwMDE5NCIsImF6cCI6IjQzNDYwMDAwMDAwMDAwMTk0IiwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vZGVwbG95bWVudF9pZCI6IjEyNjUzOmFmOWI1ZTE4ZmUyNTE0MDliZTE4ZTc3MjUzZDkxOGRjZjIyZDE1NmUiLCJleHAiOjE1NjM0MDcyMzEsImlhdCI6MTU2MzQwMzYzMSwiaXNzIjoiaHR0cHM6Ly9jYW52YXMuaW5zdHJ1Y3R1cmUuY29tIiwibm9uY2UiOiI4ZDY4MzU2MGEyMTIzM2IzYmQ0NCIsInN1YiI6ImNmY2ExNWQ4LTI5NTgtNDY0Ny1hMzNlLWE3YzRiMmRkYWIyYyIsImh0dHBzOi8vcHVybC5pbXNnbG9iYWwub3JnL3NwZWMvbHRpL2NsYWltL3RhcmdldF9saW5rX3VyaSI6Imh0dHBzOi8vaGVsbG93b3JsZC5hdG9taWNqb2x0Lnh5ei9sdGlfbGF1bmNoZXMiLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9jb250ZXh0Ijp7ImlkIjoiYWY5YjVlMThmZTI1MTQwOWJlMThlNzcyNTNkOTE4ZGNmMjJkMTU2ZSIsImxhYmVsIjoiSW50cm8gR2VvbG9neSIsInRpdGxlIjoiSW50cm9kdWN0aW9uIHRvIEdlb2xvZ3kgLSBCYWxsIiwidHlwZSI6WyJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9jb3Vyc2UjQ291cnNlT2ZmZXJpbmciXSwidmFsaWRhdGlvbl9jb250ZXh0IjpudWxsLCJlcnJvcnMiOnsiZXJyb3JzIjp7fX19LCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS90b29sX3BsYXRmb3JtIjp7Imd1aWQiOiI0TVJjeG54NnZRYkZYeGhMYjgwMDVtNVdYRk0yWjJpOGxRd2hKMVFUOmNhbnZhcy1sbXMiLCJuYW1lIjoiQXRvbWljIEpvbHQiLCJ2ZXJzaW9uIjoiY2xvdWQiLCJwcm9kdWN0X2ZhbWlseV9jb2RlIjoiY2FudmFzIiwidmFsaWRhdGlvbl9jb250ZXh0IjpudWxsLCJlcnJvcnMiOnsiZXJyb3JzIjp7fX19LCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9sYXVuY2hfcHJlc2VudGF0aW9uIjp7ImRvY3VtZW50X3RhcmdldCI6ImlmcmFtZSIsImhlaWdodCI6NTAwLCJ3aWR0aCI6NTAwLCJyZXR1cm5fdXJsIjoiaHR0cHM6Ly9hdG9taWNqb2x0Lmluc3RydWN0dXJlLmNvbS9jb3Vyc2VzLzMzMzQvZXh0ZXJuYWxfY29udGVudC9zdWNjZXNzL2V4dGVybmFsX3Rvb2xfcmVkaXJlY3QiLCJsb2NhbGUiOiJlbiIsInZhbGlkYXRpb25fY29udGV4dCI6bnVsbCwiZXJyb3JzIjp7ImVycm9ycyI6e319fSwibG9jYWxlIjoiZW4iLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9yb2xlcyI6WyJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9pbnN0aXR1dGlvbi9wZXJzb24jQWRtaW5pc3RyYXRvciIsImh0dHA6Ly9wdXJsLmltc2dsb2JhbC5vcmcvdm9jYWIvbGlzL3YyL2luc3RpdHV0aW9uL3BlcnNvbiNJbnN0cnVjdG9yIiwiaHR0cDovL3B1cmwuaW1zZ2xvYmFsLm9yZy92b2NhYi9saXMvdjIvaW5zdGl0dXRpb24vcGVyc29uI1N0dWRlbnQiLCJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9tZW1iZXJzaGlwI0luc3RydWN0b3IiLCJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9zeXN0ZW0vcGVyc29uI1VzZXIiXSwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vY3VzdG9tIjp7ImNhbnZhc19zaXNfaWQiOiIkQ2FudmFzLnVzZXIuc2lzaWQiLCJjYW52YXNfdXNlcl9pZCI6MSwiY2FudmFzX2FwaV9kb21haW4iOiJhdG9taWNqb2x0Lmluc3RydWN0dXJlLmNvbSJ9LCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS1ucnBzL2NsYWltL25hbWVzcm9sZXNlcnZpY2UiOnsiY29udGV4dF9tZW1iZXJzaGlwc191cmwiOiJodHRwczovL2F0b21pY2pvbHQuaW5zdHJ1Y3R1cmUuY29tL2FwaS9sdGkvY291cnNlcy8zMzM0L25hbWVzX2FuZF9yb2xlcyIsInNlcnZpY2VfdmVyc2lvbnMiOlsiMi4wIl0sInZhbGlkYXRpb25fY29udGV4dCI6bnVsbCwiZXJyb3JzIjp7ImVycm9ycyI6e319fSwiZXJyb3JzIjp7ImVycm9ycyI6e319fQ.dxwPkz3JF9d93QsE_My3JEhKOnsYTGRrhHOtKH31tIrN3OUk_wc9Mraj4VGtD_gZsiMcErXHtx2IRGEHcME7DYJcBx4jhTCxdUnYaEd3pUv4UEALYXIz-C6Xp7T6MsjFpW_tkknnzRZHtofd7fUy3HojW47nlZUckzv3hPdLVm3sWuLxCjd-00WY7gRmUCALiTNDVOdD0-XgwmXrCtKdo-kjPtNcGRsaksiYLHijQiyPNRp8wwvCVjpNYolhWVwtyZrwZSwzpldz367X_VMVbVbg89n7dixeZucTF01RBCWGpWqcAZ9KABfHr6fRPFexVF2iRbyEhv-rwFE5rfnx1w"
        }
      end
      context "user doesn't exist" do
        it "sets up the user, logs them in and renders the lti launch page" do
          post :index, params: @params
          expect(response).to have_http_status(200)
          expect(response.body).to include("User:")
        end
        it "creates an anonymous user" do
          @application_instance.anonymous = true
          @application_instance.save!
          post :index, params: @params
          expect(response).to have_http_status(200)
          expect(response.body).to include("User: anonymous")
        end
      end
      context "user already exists" do
        before do
          @email = FactoryBot.generate(:email)
          @user = FactoryBot.create(
            :user,
            email: @email,
            lti_user_id: @lti_user_id,
          )
        end
        it "adds lti roles to an existing user" do
          post :index, params: @params
          expect(response).to have_http_status(200)
          user = User.find_by(email: @email)
          expect(user.role?("http://purl.imsglobal.org/vocab/lis/v2/institution/person#Administrator", @context_id)).to be true
          expect(user.role?("http://purl.imsglobal.org/vocab/lis/v2/institution/person#Instructor", @context_id)).to be true
          expect(user.role?("http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student", @context_id)).to be true
          expect(user.role?("http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor", @context_id)).to be true
          expect(user.role?("http://purl.imsglobal.org/vocab/lis/v2/system/person#User", @context_id)).to be true
        end
      end
    end

    context "invalid LTI Advantage request" do
      it "should return unauthorized status" do
        params = {
          "id_token" => "yJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjIwMTktMDYtMDFUMDA6MDA6MDBaIn0.eyJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9tZXNzYWdlX3R5cGUiOiJMdGlSZXNvdXJjZUxpbmtSZXF1ZXN0IiwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vdmVyc2lvbiI6IjEuMy4wIiwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vcmVzb3VyY2VfbGluayI6eyJpZCI6ImFmOWI1ZTE4ZmUyNTE0MDliZTE4ZTc3MjUzZDkxOGRjZjIyZDE1NmUiLCJkZXNjcmlwdGlvbiI6bnVsbCwidGl0bGUiOm51bGwsInZhbGlkYXRpb25fY29udGV4dCI6bnVsbCwiZXJyb3JzIjp7ImVycm9ycyI6e319fSwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGktYWdzL2NsYWltL2VuZHBvaW50Ijp7InNjb3BlIjpbImh0dHBzOi8vcHVybC5pbXNnbG9iYWwub3JnL3NwZWMvbHRpLWFncy9zY29wZS9saW5laXRlbSIsImh0dHBzOi8vcHVybC5pbXNnbG9iYWwub3JnL3NwZWMvbHRpLWFncy9zY29wZS9yZXN1bHQucmVhZG9ubHkiLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS1hZ3Mvc2NvcGUvc2NvcmUiLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS1hZ3Mvc2NvcGUvbGluZWl0ZW0ucmVhZG9ubHkiXSwibGluZWl0ZW1zIjoiaHR0cHM6Ly9hdG9taWNqb2x0Lmluc3RydWN0dXJlLmNvbS9hcGkvbHRpL2NvdXJzZXMvMzMzNC9saW5lX2l0ZW1zIiwidmFsaWRhdGlvbl9jb250ZXh0IjpudWxsLCJlcnJvcnMiOnsiZXJyb3JzIjp7fX19LCJhdWQiOiI0MzQ2MDAwMDAwMDAwMDE5NCIsImF6cCI6IjQzNDYwMDAwMDAwMDAwMTk0IiwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vZGVwbG95bWVudF9pZCI6IjEyNjUzOmFmOWI1ZTE4ZmUyNTE0MDliZTE4ZTc3MjUzZDkxOGRjZjIyZDE1NmUiLCJleHAiOjE1NjM0MDcyMzEsImlhdCI6MTU2MzQwMzYzMSwiaXNzIjoiaHR0cHM6Ly9jYW52YXMuaW5zdHJ1Y3R1cmUuY29tIiwibm9uY2UiOiI4ZDY4MzU2MGEyMTIzM2IzYmQ0NCIsInN1YiI6ImNmY2ExNWQ4LTI5NTgtNDY0Ny1hMzNlLWE3YzRiMmRkYWIyYyIsImh0dHBzOi8vcHVybC5pbXNnbG9iYWwub3JnL3NwZWMvbHRpL2NsYWltL3RhcmdldF9saW5rX3VyaSI6Imh0dHBzOi8vaGVsbG93b3JsZC5hdG9taWNqb2x0Lnh5ei9sdGlfbGF1bmNoZXMiLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9jb250ZXh0Ijp7ImlkIjoiYWY5YjVlMThmZTI1MTQwOWJlMThlNzcyNTNkOTE4ZGNmMjJkMTU2ZSIsImxhYmVsIjoiSW50cm8gR2VvbG9neSIsInRpdGxlIjoiSW50cm9kdWN0aW9uIHRvIEdlb2xvZ3kgLSBCYWxsIiwidHlwZSI6WyJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9jb3Vyc2UjQ291cnNlT2ZmZXJpbmciXSwidmFsaWRhdGlvbl9jb250ZXh0IjpudWxsLCJlcnJvcnMiOnsiZXJyb3JzIjp7fX19LCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS90b29sX3BsYXRmb3JtIjp7Imd1aWQiOiI0TVJjeG54NnZRYkZYeGhMYjgwMDVtNVdYRk0yWjJpOGxRd2hKMVFUOmNhbnZhcy1sbXMiLCJuYW1lIjoiQXRvbWljIEpvbHQiLCJ2ZXJzaW9uIjoiY2xvdWQiLCJwcm9kdWN0X2ZhbWlseV9jb2RlIjoiY2FudmFzIiwidmFsaWRhdGlvbl9jb250ZXh0IjpudWxsLCJlcnJvcnMiOnsiZXJyb3JzIjp7fX19LCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9sYXVuY2hfcHJlc2VudGF0aW9uIjp7ImRvY3VtZW50X3RhcmdldCI6ImlmcmFtZSIsImhlaWdodCI6NTAwLCJ3aWR0aCI6NTAwLCJyZXR1cm5fdXJsIjoiaHR0cHM6Ly9hdG9taWNqb2x0Lmluc3RydWN0dXJlLmNvbS9jb3Vyc2VzLzMzMzQvZXh0ZXJuYWxfY29udGVudC9zdWNjZXNzL2V4dGVybmFsX3Rvb2xfcmVkaXJlY3QiLCJsb2NhbGUiOiJlbiIsInZhbGlkYXRpb25fY29udGV4dCI6bnVsbCwiZXJyb3JzIjp7ImVycm9ycyI6e319fSwibG9jYWxlIjoiZW4iLCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS9jbGFpbS9yb2xlcyI6WyJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9pbnN0aXR1dGlvbi9wZXJzb24jQWRtaW5pc3RyYXRvciIsImh0dHA6Ly9wdXJsLmltc2dsb2JhbC5vcmcvdm9jYWIvbGlzL3YyL2luc3RpdHV0aW9uL3BlcnNvbiNJbnN0cnVjdG9yIiwiaHR0cDovL3B1cmwuaW1zZ2xvYmFsLm9yZy92b2NhYi9saXMvdjIvaW5zdGl0dXRpb24vcGVyc29uI1N0dWRlbnQiLCJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9tZW1iZXJzaGlwI0luc3RydWN0b3IiLCJodHRwOi8vcHVybC5pbXNnbG9iYWwub3JnL3ZvY2FiL2xpcy92Mi9zeXN0ZW0vcGVyc29uI1VzZXIiXSwiaHR0cHM6Ly9wdXJsLmltc2dsb2JhbC5vcmcvc3BlYy9sdGkvY2xhaW0vY3VzdG9tIjp7ImNhbnZhc19zaXNfaWQiOiIkQ2FudmFzLnVzZXIuc2lzaWQiLCJjYW52YXNfdXNlcl9pZCI6MSwiY2FudmFzX2FwaV9kb21haW4iOiJhdG9taWNqb2x0Lmluc3RydWN0dXJlLmNvbSJ9LCJodHRwczovL3B1cmwuaW1zZ2xvYmFsLm9yZy9zcGVjL2x0aS1ucnBzL2NsYWltL25hbWVzcm9sZXNlcnZpY2UiOnsiY29udGV4dF9tZW1iZXJzaGlwc191cmwiOiJodHRwczovL2F0b21pY2pvbHQuaW5zdHJ1Y3R1cmUuY29tL2FwaS9sdGkvY291cnNlcy8zMzM0L25hbWVzX2FuZF9yb2xlcyIsInNlcnZpY2VfdmVyc2lvbnMiOlsiMi4wIl0sInZhbGlkYXRpb25fY29udGV4dCI6bnVsbCwiZXJyb3JzIjp7ImVycm9ycyI6e319fSwiZXJyb3JzIjp7ImVycm9ycyI6e319fQ.dxwPkz3JF9d93QsE_My3JEhKOnsYTGRrhHOtKH31tIrN3OUk_wc9Mraj4VGtD_gZsiMcErXHtx2IRGEHcME7DYJcBx4jhTCxdUnYaEd3pUv4UEALYXIz-C6Xp7T6MsjFpW_tkknnzRZHtofd7fUy3HojW47nlZUckzv3hPdLVm3sWuLxCjd-00WY7gRmUCALiTNDVOdD0-XgwmXrCtKdo-kjPtNcGRsaksiYLHijQiyPNRp8wwvCVjpNYolhWVwtyZrwZSwzpldz367X_VMVbVbg89n7dixeZucTF01RBCWGpWqcAZ9KABfHr6fRPFexVF2iRbyEhv-rwFE5rfnx1w"
        }
        post :index, params: params
        expect(response).to have_http_status(401)
      end
    end

    context "valid LTI request" do
      context "user doesn't exist" do
        it "sets up the user, logs them in and renders the lti launch page" do
          # Create a user with the same email as for this spec thus forcing
          # a generated email to happen for the new lti user.
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => "Learner",
            },
          )
          FactoryBot.create(:user, email: params["lis_person_contact_email_primary"])
          post :index, params: params
          expect(response).to have_http_status(200)
          expect(response.body).to include("User:")
        end
        it "creates an anonymous user" do
          @application_instance.anonymous = true
          @application_instance.save!
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => "Learner",
            },
          )
          post :index, params: params
          expect(response).to have_http_status(200)
          expect(response.body).to include("User: anonymous")
        end
      end

      context "user already exists" do
        before do
          @role = "urn:lti:role:ims/lis/Instructor"
          @email = FactoryBot.generate(:email)
          @params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => @role,
              "lis_person_contact_email_primary" => @email,
            },
          )
        end
        it "adds lti roles to an existing user" do
          FactoryBot.create(
            :user,
            email: @email,
            lti_provider: @params["tool_consumer_instance_guid"],
            lti_user_id: @params["user_id"],
          )
          post :index, params: @params
          expect(response).to have_http_status(200)
          user = User.find_by(email: @email)
          expect(user.role?(@role, @params["context_id"])).to be true
        end
        it "updates the lti_user_id of a user with a matching lms_user_id" do
          user = FactoryBot.create(
            :user,
            lti_provider: @params["tool_consumer_instance_guid"],
            lms_user_id: 23459,
          )
          params = lti_params(
            @application_instance.lti_key,
            @application_instance.lti_secret,
            {
              "launch_url" => @launch_url,
              "roles" => @role,
              "lis_person_contact_email_primary" => user.email,
              "custom_canvas_user_id" => user.lms_user_id,
            },
          )
          post :index, params: params
          expect(response).to have_http_status(200)
          user = User.find_by(email: user.email)
          expect(user.lti_user_id).to eq params["user_id"]
        end
        context "two users with matching lms_user_id exist but only one has an LTI user id" do
          it "finds the user with the lms_user_id and lti_user_id" do
            FactoryBot.create(
              :user,
              email: @email,
              lti_provider: @params["tool_consumer_instance_guid"],
              lti_user_id: @params["user_id"],
              lms_user_id: 98761,
            )
            email = FactoryBot.generate(:email)
            FactoryBot.create(
              :user,
              email: email,
              lti_provider: @params["tool_consumer_instance_guid"],
              lms_user_id: 98761,
            )
            post :index, params: @params
            expect(response).to have_http_status(200)
            user = User.find_by(email: @email)
            expect(user.lti_user_id).to eq @params["user_id"]
          end
        end
      end
    end

    context "invalid LTI request" do
      it "should return unauthorized status" do
        params = lti_params(
          @application_instance.lti_key,
          @application_instance.lti_secret,
          {
            "launch_url" => @launch_url,
          },
        )
        params[:context_title] = "invalid"
        post :index, params: params
        expect(response).to have_http_status(401)
      end
    end
  end
end
