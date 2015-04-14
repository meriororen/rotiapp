class Api::SessionsController < Devise::SessionsController
  before_filter :warden_authenticate

  def create
    sign_in(resource_name, resource)
    render json: { success: true }
  end

  def destroy
    sign_out(resource_name)
    render json: { success: true }
  end

  private

  def warden_authenticate
    self.resource = warden.authenticate!(auth_options)
  end
end
