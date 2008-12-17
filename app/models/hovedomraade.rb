class Hovedomraade < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaal
  
  validates_uniqueness_of :uuid
  
end
