class Api::RotiSalesController < Api::BaseController 
  before_filter :rotisales

  def index
    render json: [@rotisales].to_json, response: 201
  end

  def create
    clean_params
    if params[:rotisales].size > 0
      newsale = Sale.where(tanggal: date).first || Sale.create!(sale_params)
      params[:rotisales].each do |s|
        s[:rotis].each do |r|
          RotiSale.create!(
            sale_id: newsale.id, 
            roti_id: r[:id], 
            roti_amount: r[:jumlah], 
            lokasi_id: s[:lokasi][:id])
        end
      end
    else
    end
    render nothing: true, response: 201
  end

  def date
    DateTime.parse(params[:sale][:tanggal])
  end

  private

  def sale_params
    params.require(:sale).permit(:tanggal, :kelebihan, :kekurangan, :total)
  end

  def clean_params
    params[:rotisales].each do |s|
      s[:rotis].each do |r|
        s[:rotis] -= [r] if r[:jumlah] == 0
      end
      params[:rotisales] -= [s] if s[:rotis].size == 0
    end
  end

  def rotisales
    @rotisales = Hash.new
    Sale.order(:tanggal => :desc).each do |s|
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
