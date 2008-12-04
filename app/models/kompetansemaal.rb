class Kompetansemaal < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaalsett

  validates_uniqueness_of :uuid
end
