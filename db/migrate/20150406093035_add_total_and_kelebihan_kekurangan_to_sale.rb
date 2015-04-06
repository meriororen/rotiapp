class AddTotalAndKelebihanKekuranganToSale < ActiveRecord::Migration
  def change
    add_column :sales, :total, :integer
    add_column :sales, :kelebihan, :integer
    add_column :sales, :kekurangan, :integer
  end
end
