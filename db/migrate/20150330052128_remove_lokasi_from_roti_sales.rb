class RemoveLokasiFromRotiSales < ActiveRecord::Migration
  def change
    remove_column :roti_sales, :lokasi, :string
  end
end
