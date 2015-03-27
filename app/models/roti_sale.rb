class RotiSale < ActiveRecord::Base
  belongs_to :roti
  belongs_to :sale

  validates_uniqueness_of :roti_id, :scope => [ :sale_id ]
end
