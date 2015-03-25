class AddDetailsToRotis < ActiveRecord::Migration
	def change
		add_column :rotis, :nama, :string
		add_column :rotis, :harga, :string
	end
end
