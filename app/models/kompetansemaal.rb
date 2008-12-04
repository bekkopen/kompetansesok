class Kompetansemaal < ActiveRecord::Base
  validates_uniqueness_of :uuid
end
