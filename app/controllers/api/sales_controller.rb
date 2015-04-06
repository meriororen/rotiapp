class Api::SalesController < ApplicationController
  skip_before_filter :verify_authenticity_token
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
