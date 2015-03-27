class CreateRotiSales < ActiveRecord::Migration
  def change
    create_table :roti_sales do |t|
      t.references :roti, index: true, foreign_key: true
      t.references :sales, index: true, foreign_key: true
      t.integer :roti_amount
    end
  end
end
