class Api::RotiSalesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :rotisales

  def index
    render json: [@rotisales].to_json, response: 201
  end

  def create
    clean_params
    newsale = Sale.where(tanggal: date).first || Sale.create!(tanggal: date)
    params[:sales].each do |s|
      s[:rotis].each do |r|
        RotiSale.create!(sale_id: newsale.id, roti_id: r[:id], roti_amount: r[:jumlah], lokasi_id: s[:lokasi][:id])
      end
    end
    render nothing: true, response: 201
  end

  def date
    DateTime.parse(params[:tanggal])
  end

  private

  def clean_params
    params[:sales].each do |s|
      s[:rotis].each do |r|
        s[:rotis] -= [r] if r[:jumlah] == 0
      end
      params[:sales] -= [s] if s[:rotis].size == 0
    end
  end

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
