class Kompetansemaalsett < ActiveRecord::Base
  has_and_belongs_to_many :laereplaner
  has_and_belongs_to_many :kompetansemaal

  validates_uniqueness_of :uuid
  attr_accessor :laereplan_uuid
  after_create :koble_laereplan
  
  def laereplan
    laereplaner.first
  end

private

  def koble_laereplan
    laereplaner << Laereplan.find_by_uuid(laereplan_uuid)
  end
end
