module ControllerHelpers
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.build(:user)
    user.save!(:validate => false)
    sign_in user
    @current_user = user
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, type: :controller
end
