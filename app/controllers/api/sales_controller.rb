class Api::SalesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :sales

  def index
    render json: sales, response: 201
  end

  private

  def rs_params
    params.require(:sale).permit(:lokasi, :tanggal)
  end

  private

  def sales
    @sales ||= Sale.all.order(:tanggal)
  end
    
end
