class Api::RotiSalesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :rotisales

  def index
    render json: [@rotisales].to_json, response: 201
  end

  private

  def rotisales
    @rotisales = Hash.new
    Sale.all.each do |s|
      @rotisales[s.tanggal.to_time.to_i] = s.with_rotisales.map do |lokasi, roti_sale|
         { :lokasi => lokasi,
           :rotis => roti_sale.group_by { |rts| rts.roti.nama }.map do |nama, roti_sale| 
           { :nama => nama, 
             :jumlah => roti_sale[0].roti_amount, 
             :harga => roti_sale[0].roti.harga  } # roti_sale is an array
         end }
       end
    end
  end

end
