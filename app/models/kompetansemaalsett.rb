class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplaner
  has_and_belongs_to_many :kompetansemaal
  belongs_to :trinn
  
  validates_uniqueness_of :uuid
  attr_accessor :laereplan_uuid, :trinn_uuid
  after_create :koble_laereplan, :koble_trinn
  
  def laereplan
    laereplaner.first
  end

private

  def koble_laereplan
    l = Laereplan.find_by_uuid(laereplan_uuid)
    laereplaner << l unless l.nil?
  end
  
  def koble_trinn
    t = Trinn.find_by_uuid(trinn_uuid) unless trinn_uuid.nil?
    self.trinn = t unless t.nil?
    self.save!
  end
end
