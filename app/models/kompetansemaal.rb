class Kompetansemaal < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']

  has_and_belongs_to_many :kompetansemaalsett
  has_and_belongs_to_many :hovedomraader
  
  validates_uniqueness_of :uuid

end
