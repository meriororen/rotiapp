require 'spec_helper'

describe Api::RotisController, type: :controller do
  before do
    login_user
  end

  after do
    User.delete_all
  end

	it "should be able to create a new record" do
		post :create, roti: { nama: "Raspberry", harga:100 }, format: :json
    expect(response).to be_success
	end

  it "should return all rotis in database" do
    get :index
    expect(response).to be_success
  end
end
