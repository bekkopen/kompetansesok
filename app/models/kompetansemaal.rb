class Kompetansemaal < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaalsett

  validates_uniqueness_of :uuid
  
  def laereplan
    kompetansemaalsett.first.laereplan.first if not kompetansemaalsett.empty?
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
end
