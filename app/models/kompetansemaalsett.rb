class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplan

  validates_uniqueness_of :uuid
end
