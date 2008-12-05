class Kompetansemaal < ActiveRecord::Base
  belongs_to :kompetansemaalsett

  validates_uniqueness_of :uuid
end
