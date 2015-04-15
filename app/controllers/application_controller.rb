class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  acts_as_token_authentication_handler_for User, :fallback_to_devise => false

  def permission_denied
    render file: 'public/404.html', layout: false, status: :unauthorized
  end

end
