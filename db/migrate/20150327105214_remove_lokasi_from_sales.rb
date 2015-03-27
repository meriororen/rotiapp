class RemoveLokasiFromSales < ActiveRecord::Migration
  def change
    remove_column :sales, :lokasi, :string
  end
end
