class TemplatesController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  before_filter :authentication_required!, only: [ :template ]

  def index
  end

  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end

  private

  def authentication_required!
    throw(:warden, scope: :user) unless current_user.presence
  end
end
