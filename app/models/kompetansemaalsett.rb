class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplaner
  has_and_belongs_to_many :kompetansemaal

  validates_uniqueness_of :uuid
  
  def laereplan
    laereplaner.first
  end
end
