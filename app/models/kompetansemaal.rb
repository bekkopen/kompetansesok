class Kompetansemaal < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaalsett

  validates_uniqueness_of :uuid

  attr_accessor :kompetansemaalsett_uuid
  after_create :koble_kompetansemaalsett

  def laereplan
    kompetansemaalsett.first.laereplan if not kompetansemaalsett.empty?
  end

  def laereplan_tittel
    laereplan ? laereplan.tittel : ""
  end

  def kompetansemaalsett_tittel
    if kompetansemaalsett.empty?
      ""
    else
      kompetansemaalsett.first.tittel
    end
  end
  
private

  def koble_kompetansemaalsett
    kompetansemaalsett << Kompetansemaalsett.find_by_uuid(kompetansemaalsett_uuid)
  end
end
