class Fag < ActiveRecord::Base
  is_indexed :fields => ['tittel', 'uuid', 'kode']
  
  has_and_belongs_to_many :kompetansemaalsett
  
  def ikon_tekst
    'F&nbsp;'
  end

  def to_param
    uuid
  end
  
  def kompetansemaal
    kompetansemaalsett.map do |maalsett|
      maalsett.kompetansemaal
    end.flatten.uniq
  end
end
