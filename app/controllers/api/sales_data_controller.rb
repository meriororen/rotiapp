class SalesDataController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :salesdata

  def index
    render json: [@salesdata].to_json, response: 201
  end

  private

  def salesdata
    @salesdata = Hash.new
    Sale.all.each do |s|
      @salesdata[s.tanggal.to_formatted_s(:short)] = s.with_rotisales.map do |lokasi, roti_sale|
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
