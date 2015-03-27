class RemoveRotiIdFromRotis < ActiveRecord::Migration
  def change
    remove_column :rotis, :roti_id, :integer
  end
end
