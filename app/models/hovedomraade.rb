class Hovedomraade < ActiveRecord::Base
  
  validates_uniqueness_of :uuid
  
end
