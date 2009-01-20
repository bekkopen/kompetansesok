class Fag < ActiveRecord::Base
  has_and_belongs_to_many :kompetansemaalsett
  
  def to_param
    uuid
  end
  
  def kompetansemaal
    kompetansemaalsett.map do |maalsett|
      maalsett.kompetansemaal
    end.flatten.uniq
  end
end
