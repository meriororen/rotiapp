class Sale < ActiveRecord::Base
  has_many :roti_sales
  has_many :rotis, -> { uniq }, :through => :roti_sales

  validates_uniqueness_of :tanggal
end
