class Sale < ActiveRecord::Base
  has_many :roti_sales
  has_many :rotis, -> { uniq }, :through => :roti_sales

  # which one?
  # has_one roti_sale of roti (has_one roti through roti_sale)
  # has_many roti_sales of rotis (has_many rotis through roti_sales)
end
