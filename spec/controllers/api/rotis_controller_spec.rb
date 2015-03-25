require 'rails_helper'

describe Api::RotisController, type: :controller do
	it "should be able to create a new record" do
		post :create, roti: { nama: "Raspberry", harga:100 }, format: :json
		response.should be_success
		JSON.parse(response.body).should == { 'id' => 1, 'nama' => "Raspberry", 'harga' => "100" }
	end
end
