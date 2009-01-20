class Fag < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']
  
  has_and_belongs_to_many :kompetansemaalsett
  
  def to_param
    uuid
  end
end
