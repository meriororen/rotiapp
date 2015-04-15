class User < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end
end
