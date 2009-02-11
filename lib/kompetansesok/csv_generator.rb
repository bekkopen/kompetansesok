
module Kompetansesok

  class CsvGenerator
    
    
    def csv_for(kompetansemaal_uuids)
      FasterCSV.generate do |csv|
        csv << KompetansemaalRad.header_row
        rows_for(kompetansemaal_uuids).each do |row|
          csv << row
        end
      end
    end
        
     
    private 
    
    def rows_for(kompetansemaal_uuids)
      kompetansemaal = find_kompetansemaal(kompetansemaal_uuids)
      
      rows = []
      kompetansemaal.each do |maal|
        rows = rows + rows_through_laereplan(maal) + rows_through_fag(maal)
      end
      rows
    end
    
    def find_kompetansemaal(uuids)
      if uuids.blank?
        []
      else
        uuids.split(',').map { |uuid| Kompetansemaal.find_by_uuid(uuid) }
      end
    end
    
    def rows_through_laereplan(maal)
      rows = []
      maal.kompetansemaalsett.each do |sett|
        maal.hovedomraader.each do |hovedomraade|
          hovedomraade.laereplaner.each do |laereplan|
            row_info = uuid_kode_and_tittel(maal, laereplan, hovedomraade, sett) 
            rows << KompetansemaalRad.new(row_info).to_a
          end
        end
      end
      rows
    end
    
    def rows_through_fag(maal) 
      rows = []
      
      maal.kompetansemaalsett.each do |sett|
        sett.fag.each do |f|
          row_info = uuid_kode_and_tittel(maal, f, sett) 
          rows << KompetansemaalRad.new(row_info).to_a
        end
      end
      rows
    end
    
    def uuid_kode_and_tittel(*models)
      all_models_info = {}
      models.each do |model|
        key_prefix = model.class.to_s.singularize.downcase
        all_models_info["#{key_prefix}_uuid".to_sym] = model.uuid
        all_models_info["#{key_prefix}_kode".to_sym] = model.kode
        all_models_info["#{key_prefix}_tittel".to_sym] = model.tittel
      end
      all_models_info
    end
   
        
  end

end

