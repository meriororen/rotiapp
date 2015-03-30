class CreateLokasis < ActiveRecord::Migration
  def change
    create_table :lokasis do |t|
      t.string :nama
    end
  end
end
