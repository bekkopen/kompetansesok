class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplaner

  validates_uniqueness_of :uuid
  
  def laereplan
    laereplaner.first
  end
end
