class Lokasi < ActiveRecord::Base
  has_many :roti_sales
  has_many :rotis, -> { uniq }, :through => :roti_sales
  has_many :sales, -> { uniq }, :through => :roti_sales
end
