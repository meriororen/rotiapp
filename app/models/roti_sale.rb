class RotiSale < ActiveRecord::Base
  belongs_to :roti
  belongs_to :sale

  validates_presence_of :roti, :sale, :lokasi
  validates_uniqueness_of :roti_id, :scope => [ :sale_id, :lokasi ]
  validates_uniqueness_of :lokasi, :scope => [ :sale_id, :roti_id ]
end
