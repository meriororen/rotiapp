class FixRotiSales < ActiveRecord::Migration
  def self.up
    rename_column :roti_sales, :sales_id, :sale_id
  end

  def self.down

  end
end
