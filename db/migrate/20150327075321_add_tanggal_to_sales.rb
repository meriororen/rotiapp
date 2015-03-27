class AddTanggalToSales < ActiveRecord::Migration
  def change
    add_column :sales, :tanggal, :datetime
  end
end
