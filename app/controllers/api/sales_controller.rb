class Api::SalesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :sales

  def index
    render json: [@sales].to_json, response: 201
  end

  private

  def rs_params
    params.require(:sale).permit(:lokasi, :tanggal)
  end

  def sales
    @sales = Hash.new
    Sale.all.each do |s|
      @sales[s.tanggal.to_formatted_s(:short)] = s.with_rotisales.map do |lokasi, roti_sale|
           { :lokasi => lokasi,
             :rotis => roti_sale.group_by { |rts| rts.roti.nama }.map { |nama, roti_sale| { nama => roti_sale[0].roti_amount } } }
       end
    end
  end

  # should be
  # "2015-02-2" =>
  #     [ "Ookayama" => 
  #         { ["Choco-Banana" =>
  #           {
  #             "id" => 1,
  #             "roti_id" => 23,
  #             "sale_id" => 3,
  #             "roti_amount" => 23,
  #             "lokasi" => "Ookayama"
  #           },
  #           "Chocolate" =>
  #           {
  #             "id" => 2,
  #             "roti_id" => 24,
  #             "sale_id" => 3,
  #             "roti_amount" => 10,
  #             "lokasi" => "Ookayama"
  #           }]
  #        
  #         },
  #       "Suzukakedai" =>
  #         { ["...
end
