
module Kompetansesok

  class CsvGenerator
    
    def rows_for(kompetansemaal_uuids)
      kompetansemaal = find_kompetansemaal(kompetansemaal_uuids)
      
      rows = kompetansemaal.map do |maal|
        [maal.uuid, maal.kode, maal.tittel]
      end
      
      rows
    end
    
    
    
    
    private 
    
    def find_kompetansemaal(uuids)
      uuids.split(', ').map { |uuid| Kompetansemaal.find_by_uuid(uuid) }
    end
    
    
    
  end

end
