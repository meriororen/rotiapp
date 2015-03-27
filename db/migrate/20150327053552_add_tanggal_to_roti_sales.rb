class AddTanggalToRotiSales < ActiveRecord::Migration
  def change
    add_column :roti_sales, :tanggal, :datetime
  end
end
