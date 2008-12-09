class Kompetansemaal < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaalsett
  has_and_belongs_to_many :hovedomraader
  
  validates_uniqueness_of :uuid

  attr_accessor :kompetansemaalsett_uuid, :hovedomraade_uuid
  after_create :koble_kompetansemaalsett, :koble_hoovedomraade

  def laereplan
    kompetansemaalsett.first.laereplan if not kompetansemaalsett.empty?
  end

  def laereplan_tittel
    laereplan.nil? ? "": laereplan.tittel
  end

  def kompetansemaalsett_tittel
    kompetansemaalsett.empty? ? "" : kompetansemaalsett.first.tittel
  end
  
  def kompetansemaalsett_trinn
    if(kompetansemaalsett.empty? || kompetansemaalsett.first.trinn.nil?)
      ""
    else
      kompetansemaalsett.first.trinn.tittel
    end
  end
  
  def hovedomraade_tittel
    hovedomraader.empty? ? "" : hovedomraader.first.tittel
  end
  
private

  def koble_kompetansemaalsett
    r = Kompetansemaalsett.find_by_uuid(kompetansemaalsett_uuid)
    kompetansemaalsett << r unless r.nil?
  end
  
  def koble_hoovedomraade
    r = Hovedomraade.find_by_uuid(hovedomraade_uuid) unless hovedomraade_uuid.nil?
    hovedomraader << r unless r.nil?
  end
end
