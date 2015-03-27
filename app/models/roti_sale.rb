class RotiSale < ActiveRecord::Base
  belongs_to :roti, foreign_key: :roti_id
  belongs_to :sale, foreign_key: :sale_id

  validates_presence_of :roti, :sale, :lokasi
  validates_uniqueness_of :roti_id, :scope => [ :sale_id ]
  validates_uniqueness_of :lokasi, :scope => [ :sale_id ]
end
