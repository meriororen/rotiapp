class AddPenanggungJawabToLokasis < ActiveRecord::Migration
  def change
    add_column :lokasis, :penanggung_jawab, :string
  end
end
