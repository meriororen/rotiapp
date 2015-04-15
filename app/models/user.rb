class User < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def clear_authentication_token!
    # force renew auth token by first nilling it
    # let simple_token_auth gem renew it
    update_attribute(:authentication_token, nil)
  end
end
