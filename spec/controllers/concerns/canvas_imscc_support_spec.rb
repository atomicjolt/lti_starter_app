require "rails_helper"

describe ApplicationController, type: :controller do
  before do
    setup_application_instance
    # For authentication a JWT will be included in the Authorization header using the Bearer scheme,
    # it is signed using the shared secret for the tool and will include the stored consumer key in the
    # kid field of the token's header object.
    payload = {}
    @token = AuthToken.issue_token(
      payload,
      24.hours.from_now,
      @application_instance.lti_secret,
      nil,
      { kid: @application_instance.lti_key },
    )
  end

  controller do
    include Concerns::CanvasImsccSupport
    def create
      render json: { message: "all is well" }
    end
  end

  it "Returns unauthorized if no token is found" do
    post :create, params: {}, format: :json
    expect(response).to have_http_status(:unauthorized)
  end

  it "Returns unauthorized if the header isn't properly formed" do
    request.headers["Authorization"] = @token
    post :create, params: {}, format: :json
    expect(response).to have_http_status(:unauthorized)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("Unauthorized: Invalid token: Invalid authorization header.")
  end

  it "Returns unauthorized if the kid header value has a bad ltt key" do
    bad_token = AuthToken.issue_token(
      {},
      24.hours.from_now,
      @application_instance.lti_secret,
      nil,
      { kid: "anybadltikey" },
    )
    request.headers["Authorization"] = bad_token
    post :create, params: {}, format: :json
    expect(response).to have_http_status(:unauthorized)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("Unauthorized: Invalid token: Invalid authorization header.")
  end

  it "Returns unauthorized if the token has the wrong signature" do
    bad_token = AuthToken.issue_token(
      {},
      24.hours.from_now,
      "arandomsecretvalue",
      nil,
      { kid: @application_instance.lti_key },
    )
    request.headers["Authorization"] = "Bearer #{bad_token}"
    post :create, params: {}, format: :json
    expect(response).to have_http_status(:unauthorized)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("Unauthorized: Invalid token: Signature verification raised")
  end

  it "Returns true if the token is valid" do
    request.headers["Authorization"] = "Bearer #{@token}"
    post :create, params: {}, format: :json
    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json["message"]).to eq("all is well")
  end

  it "sets @application_instance" do
    request.headers["Authorization"] = "Bearer #{@token}"
    post :create, params: {}, format: :json
    expect(assigns(:application_instance)).to eq(@application_instance)
  end
end
