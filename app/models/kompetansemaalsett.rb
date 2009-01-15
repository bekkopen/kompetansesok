class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplaner
  has_and_belongs_to_many :kompetansemaal
  has_and_belongs_to_many :trinn
  has_and_belongs_to_many :fag
  
  validates_uniqueness_of :uuid
  attr_accessor_with_default :trinn_uuids, []
  attr_accessor_with_default :laereplan_uuids, []
  attr_accessor_with_default :fag_uuids, []
  after_create :koble_laereplan, :koble_trinn, :koble_fag
  
  
  private

  def koble_laereplan
    laereplan_uuids.each do |laereplan_uuid|
      l = Laereplan.find_by_uuid(laereplan_uuid)
      laereplaner << l unless l.nil?
    end
  end
  
  def koble_trinn
    trinn_uuids.each do |trinn_uuid|
      t = Trinn.find_by_uuid(trinn_uuid)
      trinn << t unless t.nil?
    end
  end
  
  def koble_fag
    fag_uuids.each do |fag_uuid|
      f = Fag.find_by_uuid(fag_uuid)
      fag << f unless f.nil?
    end
  end
end
