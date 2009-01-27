class Laereplan < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']
  
  has_and_belongs_to_many :kompetansemaalsett
  has_and_belongs_to_many :hovedomraader
  
  validates_uniqueness_of :uuid
  
  attr_accessor_with_default :hovedomraade_uuids, []
  attr_accessor_with_default :kompetansemaalsett_uuids, []
  
  after_create :koble_hovedomraader, :koble_kompetansemaalsett
  
  def kompetansemaal
    gjennom_maalsett = kompetansemaalsett.map {|maalsett| maalsett.kompetansemaal }
    gjennom_hovedomraade = hovedomraader.map {|hovedomraade| hovedomraade.kompetansemaal }
    alle = gjennom_maalsett + gjennom_hovedomraade
    alle.flatten.uniq
  end

  def ikon_tekst
    'LP'
  end

  def to_param
    uuid
  end  
  
  private
  
  def koble_hovedomraader
    hovedomraade_uuids.each do |hovedomraade_uuid|
      h = Hovedomraade.find_by_uuid(hovedomraade_uuid)
      hovedomraader << h unless h.nil?
    end
  end
  
  def koble_kompetansemaalsett
    kompetansemaalsett_uuids.each do |kompetansemaalsett_uuid|
      sett = Kompetansemaalsett.find_by_uuid(kompetansemaalsett_uuid)
      kompetansemaalsett << sett unless sett.nil?
    end
  end
  
end
