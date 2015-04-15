require 'spec_helper'

describe 'API auth' do
  include JsonApiHelpers

  before do
    @user = create(:user)
  end

  describe "POST /api/session", type: :request do
    it "should return auth_token for valid HTTP Basic credentials" do
      authenticate_successfully
      expect(response.status).to eq(200)
      expect(json_response["auth_token"]).to_not be_blank
    end

    it "should return error json when HTTP Basic credentials are invalid" do
      post '/api/session', {}, http_basic(@user.email, "badpassword")
      expect(response.status).to eq(401)
      expect(json_response).to eq({"error" => "Invalid email or password."})
    end

    it "should return error json when HTTP Basic credentials are missing" do
      post '/api/session'
      expect(response.status).to eq(401)
      expect(json_response).to eq({"error" => "You need to sign in or sign up before continuing."})
    end
  end

  describe "DELETE /api/session", type: :request do
    it "should return HTTP 200 OK when session exists" do
      authenticate_successfully
      auth_token = json_response["auth_token"]
      delete '/api/session', { 'user_token' => auth_token, 'user_email' => @user.email }
      expect(response).to be_ok
    end

    it "should return HTTP 401 Unauthorized when session didn't exist" do
      delete '/api/session'
      expect(response.status).to eq(401)
      expect(json_response['error']).to eq('You need to sign in or sign up before continuing.')
    end
  end

  private

  def authenticate_successfully
    post '/api/session', {}, http_basic(@user.email, "hogehoge8")
  end

  def http_basic(user, password)
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials(user, password) 
    { 'HTTP_AUTHORIZATION' => credentials }
  end
end
