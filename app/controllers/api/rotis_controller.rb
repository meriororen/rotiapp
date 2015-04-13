class Api::RotisController < ApplicationController
  before_filter :authenticate_user!

	def index
    render json: rotis, status: 201 
	end

	def create
		roti = Roti.create!(roti_params)
		render json: roti, status: 201
	end

	def update
		roti.update_attributes(roti_params)
		render nothing: true, status: 204
	end

	def destroy
    roti.destroy
    render nothing: true, status: 204
	end

private
	def roti_params
		params.require(:roti).permit(:nama, :harga)
	end

  def rotis
    @rotis ||= Roti.all
  end

  def roti
    @roti ||= rotis.find(params[:id])
  end

end
