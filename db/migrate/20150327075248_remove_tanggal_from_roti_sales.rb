class RemoveTanggalFromRotiSales < ActiveRecord::Migration
  def change
    remove_column :roti_sales, :tanggal, :datetime
  end
end
