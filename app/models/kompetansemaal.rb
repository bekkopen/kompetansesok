class Kompetansemaal < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']

  has_and_belongs_to_many :kompetansemaalsett
  has_and_belongs_to_many :hovedomraader
  
  validates_uniqueness_of :uuid

  attr_accessor_with_default :kompetansemaalsett_uuids, []
  attr_accessor_with_default :hovedomraade_uuids, []
  after_create :koble_kompetansemaalsett, :koble_hoovedomraade

  
  private

  def koble_kompetansemaalsett
    kompetansemaalsett_uuids.each do |kompetansemaalsett_uuid|
      r = Kompetansemaalsett.find_by_uuid(kompetansemaalsett_uuid)
      kompetansemaalsett << r unless r.nil?
    end
  end
  
  def koble_hoovedomraade
    hovedomraade_uuids.each do |hovedomraade_uuid|
      r = Hovedomraade.find_by_uuid(hovedomraade_uuid) unless hovedomraade_uuid.nil?
      hovedomraader << r unless r.nil?
    end
  end
end
