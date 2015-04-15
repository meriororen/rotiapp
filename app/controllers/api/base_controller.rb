class Api::BaseController < ApplicationController
  acts_as_token_authentication_handler_for User, :fallback_to_devise => false

  protect_from_forgery with: :null_session
  before_action :require_authentication!

  def permission_denied
    render file: 'public/404.html', layout: false, status: :unauthorized
  end

  private
  
  def require_authentication!
    throw(:warden, scope: :user) unless current_user.presence
  end
end
