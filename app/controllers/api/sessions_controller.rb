class Api::SessionsController < Devise::SessionsController
  skip_before_filter :verify_signed_out_user, only: [ :destroy ]
  skip_before_filter :verify_authenticity_token
  before_filter :warden_authenticate

  def create
    sign_in(resource_name, resource)
    current_user.clear_authentication_token!
    respond_to do |format|
      format.json { render json: { auth_token: current_user.authentication_token } }
      format.html { redirect_to dashboard_path }
    end
  end

  def destroy
    if current_user
      current_user.clear_authentication_token!
      signed_out = Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      respond_to do |format|
        format.json { render json: { status: :ok }.to_json, status: :ok }
        format.html { redirect_to root_path, flash: { :notice => "Successfully signed out." } }
      end
    else
      respond_to do |format|
        format.json { render json: {}, status: :unprocessable_entity }
        format.html { redirect_to root_path, flash: { :error => "You are not signed in." } }
      end
    end
  end

  private

  def warden_authenticate
    self.resource = warden.authenticate!(auth_options)
  end
end
