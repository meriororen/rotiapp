class Api::RotisController < ApplicationController

	def index
    rotis = Roti.all
    render json: rotis, status: 201 
	end

	def create
		roti = Roti.create(roti_params)
		render json: roti, status: 201
	end

	def update
		roti.update_attributes(roti_params)
		render nothing: true, status: 204
	end

	def destroy
	end

private
	def roti_params
		params.require(:roti).permit(:nama, :harga)
	end

end
