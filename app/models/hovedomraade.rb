class Hovedomraade < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']
  
  has_and_belongs_to_many :kompetansemaal
  has_and_belongs_to_many :laereplaner
  
  validates_uniqueness_of :uuid
  
  def to_param
    uuid
  end
  
end
