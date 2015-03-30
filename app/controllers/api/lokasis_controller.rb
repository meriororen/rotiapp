class Api::LokasisController < ApplicationController
  def index
    render json: Lokasi.all, response: 201
  end
end
