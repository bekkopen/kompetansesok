class Laereplan < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaalsett
  
  validates_uniqueness_of :uuid
  
  def kompetansemaal
    result = kompetansemaalsett.map do |maalsett| 
      maalsett.kompetansemaal
    end
    result.flatten.uniq
  end
end
