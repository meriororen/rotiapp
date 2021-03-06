class Sale < ActiveRecord::Base
  has_many :roti_sales
  has_many :rotis, -> { uniq }, :through => :roti_sales
  has_many :lokasis, -> { uniq }, :through => :roti_sales
  accepts_nested_attributes_for :roti_sales, :rotis, :lokasis

  validates_uniqueness_of :tanggal

  def with_rotisales
    self.roti_sales.group_by { |rts| rts.lokasi }
  end

  def rotis_by_nama
    self.rotis.group_by { |r| r.nama }
  end

  def by_tanggal
    { self.tanggal => self }
  end
end
