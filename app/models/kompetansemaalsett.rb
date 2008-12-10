class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplaner
  has_and_belongs_to_many :kompetansemaal
  has_and_belongs_to_many :trinn
  
  validates_uniqueness_of :uuid
  attr_accessor_with_default :trinn_uuids, []
  attr_accessor_with_default :laereplan_uuids, []
  after_create :koble_laereplan, :koble_trinn
  
  def laereplan
    laereplaner.first
  end

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
end
