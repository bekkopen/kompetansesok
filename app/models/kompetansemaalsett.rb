class Kompetansemaalsett < ActiveRecord::Base
  belongs_to :laereplan

  validates_uniqueness_of :uuid
end
