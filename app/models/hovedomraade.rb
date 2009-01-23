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
  
  def kompetansemaal_for_laereplan(laereplan)
    kompetansemaal.map do |maal|
      maal if maal.laereplaner.include?(laereplan)
    end.compact
  end
  
  def kompetansemaalsett
    kompetansemaal.map do |maal|
      maal.kompetansemaalsett
    end.flatten.uniq
  end
  
  def kompetansemaalsett_for_laereplan(laereplan)
    kompetansemaal_for_laereplan(laereplan).map do |maal|
      maal.kompetansemaalsett
    end.flatten.uniq
  end
  
  private
  
  def koble_kompetansemaal
    kompetansemaal_uuids.each do |kompetansemaal_uuid|
      r = Kompetansemaal.find_by_uuid(kompetansemaal_uuid)
      kompetansemaal << r unless r.nil?
    end
  end
  
end
