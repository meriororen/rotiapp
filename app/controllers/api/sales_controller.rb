class Api::SalesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :sales

  def index
    render json: sales, response: 201
  end

  def create
    Sale.create!(s_params)
  end

  private

  def s_params
    params.require(:sale).permit(:tanggal, :kelebihan, :kekurangan, :total)
  end

  def sales
    @sales ||= Sale.order(:tanggal => :desc)
  end
    
end
