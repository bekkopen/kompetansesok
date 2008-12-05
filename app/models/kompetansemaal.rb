class Kompetansemaal < ActiveRecord::Base
  belongs_to :kompetansemaalsett

  validates_uniqueness_of :uuid

  def laereplan
    kompetansemaalsett.laereplan if kompetansemaalsett
  end

  def laereplan_tittel
    laereplan ? laereplan.tittel : ""
  end


  def kompetansemaalsett_tittel
    kompetansemaalsett ? kompetansemaalsett.tittel : ""
  end
end
