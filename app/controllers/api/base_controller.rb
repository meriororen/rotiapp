class Api::BaseController < ApplicationController
  before_filter :authenticate_user!

  def permission_denied
    render json: { error: 'unauthorized' }, status: :unauthorized
  end
end
