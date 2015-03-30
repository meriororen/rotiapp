class Roti < ActiveRecord::Base
  has_many :roti_sales
  has_many :sales, :through => :roti_sales
  has_many :lokasis, :through => :roti_sales
end
