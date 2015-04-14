require 'spec_helper'
require 'rails_helper'

describe Api::RotisController, type: :controller do
	it "should be able to create a new record" do
    login_user
		post :create, roti: { nama: "Raspberry", harga:100 }, format: :json
    expect(response).to be_success
	end

  it "should return all rotis in database" do
    login_user
    get :index
    expect(response).to be_success
  end
end
