class Api::SalesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :sales

  def index
    render json: @sales.to_json( include: [:rotis, :roti_sales] ), response: 201
  end

  private

  def rs_params
    params.require(:sale).permit(:lokasi, :tanggal)
  end

  def sales
    @sales ||= Sale.order('tanggal')
  end
end