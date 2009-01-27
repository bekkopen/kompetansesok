module Kompetansesok
  
  class KompetansemaalRad
    @@felter =  [:kompetansemaal_uuid, :kompetansemaal_kode, :kompetansemaal_tittel, 
      :laereplan_uuid, :laereplan_kode, :laereplan_tittel, 
      :hovedomraade_uuid, :hovedomraade_kode, :hovedomraade_tittel,
      :kompetansemaalsett_uuid, :kompetansemaalsett_kode, :kompetansemaalsett_tittel,
      :fag_uuid, :fag_kode, :fag_tittel]
    
    @@felter.each do |f|
      class_eval do
        attr_accessor f
      end
    end
    
    def self.header_row
      @@felter.map {|felt| I18n.t("csv.#{felt}")}
    end
    
    
    def initialize(params = {})
      @@felter.each {|felt| self.send("#{felt}=", params[felt]) }
    end
    
    def to_a
      @@felter.map {|felt| self.send(felt) }
    end
     
  end
  
end