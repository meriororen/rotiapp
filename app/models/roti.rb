class Roti < ActiveRecord::Base
  has_many :roti_sales
  has_many :sales, -> { uniq }, :through => :roti_sales
end
