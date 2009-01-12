class Hovedomraade < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaal
  has_and_belongs_to_many :laereplaner
  
  validates_uniqueness_of :uuid
  
end
