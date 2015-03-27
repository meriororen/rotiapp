class AddLokasiToRotiSales < ActiveRecord::Migration
  def change
    add_column :roti_sales, :lokasi, :string
  end
end
