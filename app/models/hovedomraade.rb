class Hovedomraade < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']
  
  has_and_belongs_to_many :kompetansemaal
  has_and_belongs_to_many :laereplaner
  
  validates_uniqueness_of :uuid
  
  attr_accessor_with_default :kompetansemaal_uuids, []
  
  after_create :koble_kompetansemaal
  
  def to_param
    uuid
  end
  
  private
  
  def koble_kompetansemaal
    kompetansemaal_uuids.each do |kompetansemaal_uuid|
      r = Kompetansemaal.find_by_uuid(kompetansemaal_uuid)
      kompetansemaal << r unless r.nil?
    end
  end
  
end
