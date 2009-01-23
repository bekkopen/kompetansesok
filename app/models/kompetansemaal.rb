class Kompetansemaal < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']

  has_and_belongs_to_many :kompetansemaalsett
  has_and_belongs_to_many :hovedomraader
  
  validates_uniqueness_of :uuid
  
  def laereplaner
    gjennom_maalsett = kompetansemaalsett.map {|maalsett| maalsett.laereplaner }
    gjennom_hovedomraade = hovedomraader.map {|hovedomraade| hovedomraade.laereplaner }
    alle = gjennom_maalsett + gjennom_hovedomraade
    alle.flatten.uniq
  end

  def fag
    kompetansemaalsett.map do |maalsett|
      maalsett.fag
    end.flatten.uniq
  end
end
