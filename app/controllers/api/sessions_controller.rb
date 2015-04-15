class Api::SessionsController < Devise::SessionsController
  skip_before_filter :verify_signed_out_user, only: [ :destroy ]
  skip_before_filter :verify_authenticity_token
  before_filter :warden_authenticate

  def create
    sign_in(resource_name, resource)
    current_user.clear_authentication_token!
    render json: { user: current_user, status: :ok, auth_token: current_user.authentication_token }
  end

  def destroy
    if current_user
      current_user.clear_authentication_token!
      signed_out = Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      render json: {}, status: :ok
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def warden_authenticate
    self.resource = warden.authenticate!(auth_options)
  end
end
