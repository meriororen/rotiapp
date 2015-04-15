class Api::SessionsController < Devise::SessionsController
  before_filter :warden_authenticate

  def create
    sign_in(resource_name, resource)
    current_user.clear_authentication_token!
    render json: { user: current_user, status: :ok, auth_token: current_user.authentication_token }
  end

  def destroy
    if current_user
      current_user.clear_authentication_token!
      sign_out(resource_name)
      render json: {}.to_json, status: :ok
    else
      render json: {}.to_json, status: :unprocessable_entity
    end
  end

  private

  def warden_authenticate
    self.resource = warden.authenticate!(auth_options)
  end
end
