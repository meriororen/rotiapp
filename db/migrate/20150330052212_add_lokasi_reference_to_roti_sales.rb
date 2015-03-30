class AddLokasiReferenceToRotiSales < ActiveRecord::Migration
  def change
    add_reference :roti_sales, :lokasi, index: true, foreign_key: true
  end
end
