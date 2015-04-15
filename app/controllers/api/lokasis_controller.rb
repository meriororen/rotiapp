class Api::LokasisController < ApplicationController
  def index
    render json: Lokasi.all, response: 201
  end

  def create
    Lokasi.create!(lokasi_params)
    render nothing: true, response: 201
  end

  def update
    roti.update_attributes(lokasi_params)
    render nothing: true, status: 204
  end

  def destroy
    Lokasi.find(params[:id]).destroy
    render nothing: true, response: 204
  end

  private 

  def lokasi_params
    params.require(:lokasi).permit(:nama, :penanggung_jawab)
  end
end
