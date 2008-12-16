module Kompetansesok
  
  class KompetansemaalRad
    @@soekefelter = [:laereplan_tittel, :hovedomraade_tittel, :kompetansemaalsett_tittel, 
                     :maal_uuid, :maal_kode, :trinn_tittel, :maal_tittel]
    
    @@soekefelter.each do |f|
      class_eval do
        attr_accessor f
      end
    end
    
    def initialize(params = {})
      @@soekefelter.each {|soekefelt| self.send("#{soekefelt}=", params[soekefelt]) }
    end
    
    def as_row
      [laereplan_tittel, hovedomraade_tittel, kompetansemaalsett_tittel, trinn_tittel, maal_uuid, maal_kode, maal_tittel]
    end
  end
  
  
end
