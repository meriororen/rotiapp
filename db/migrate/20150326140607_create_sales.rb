class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :lokasi
    end
  end
end
