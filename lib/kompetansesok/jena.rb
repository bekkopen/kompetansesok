Dir[File.dirname(__FILE__) + '/../ext/jena-2.5.6/*.jar'].each do |jar|
  require jar
end

module Kompetansesok
  
  class Jena
    GREP_NS = 'http://psi.udir.no/ontologi/'

    def initialize
      @model = com.hp.hpl.jena.rdf.model.ModelFactory.createDefaultModel
      @title_property          = com.hp.hpl.jena.vocabulary.DC_11.title
      @type_property           = com.hp.hpl.jena.vocabulary.RDF.type
      @kode_property                                  = @model.getProperty(GREP_NS, 'kode')
      @kompetansemaalsett_har_kompetansemaal_property = @model.getProperty(GREP_NS, 'kompetansemaalsett_har_kompetansemaal')
      @kompetansemaalsett_etter_laereplan_property    = @model.getProperty(GREP_NS, 'kompetansemaalsett_etter_laereplan')
      @tilhoerer_hovedomraade_property                = @model.getProperty(GREP_NS, 'tilhoerer_hovedomraade')
      @kompetansemaalsett_etter_aarstrinn_property    = @model.getProperty(GREP_NS, 'kompetansemaalsett_etter_aarstrinn')
      @hovedomraader_property                         = @model.getProperty(GREP_NS, 'hovedomraader')
    end
    
    def les_rdf_fil(rdf_fil)
      f = com.hp.hpl.jena.util.FileManager.get.open(rdf_fil)
      @model.read(f, "")
    end

    def les_rdf_url(rdf_url)
      @model.read(rdf_url, "")
    end
    
    def write(out)
      @model.write(out.to_outputstream)
    end
    
    # Returnerer alle kompetansemaal som Array av Hash. Hver Hash er et key-value par med primitive verdier.
    def kompetansemaal
      @kompetansemaal ||= @model.listResourcesWithProperty(@kompetansemaalsett_har_kompetansemaal_property).map do |r|
        {
          :uuid => r.to_s,
          :tittel => tittel(r),
          :kode => kode(r),
          :kompetansemaalsett_uuids => uuids(r, @kompetansemaalsett_har_kompetansemaal_property),
          :hovedomraade_uuids => uuids(r, @tilhoerer_hovedomraade_property)
        }
      end.sort{|a, b| a[:tittel] <=> b[:tittel]}
    end
    
    def laereplaner
      @laereplaner ||= @model.listObjectsOfProperty(@kompetansemaalsett_etter_laereplan_property).map do |r|
        { 
          :uuid => r.to_s,
          :kode => kode(r),
          :tittel => tittel(r),
          :hovedomraade_uuids => uuids(r, @hovedomraader_property)
        }
      end.sort{|a, b| a[:tittel] <=> b[:tittel]}
    end
    
    # Kompetansemaalsett trenger ikke ha trinn
    def kompetansemaalsett
      @kompetansemaalsett ||= @model.listObjectsOfProperty(@kompetansemaalsett_har_kompetansemaal_property).map do |r|        
        { 
          :uuid => r.to_s,
          :tittel => tittel(r),
          :laereplan_uuids => uuids(r, @kompetansemaalsett_etter_laereplan_property),
          :trinn_uuids => uuids(r, @kompetansemaalsett_etter_aarstrinn_property)
        }
      end.sort{|a, b| a[:tittel] <=> b[:tittel]}
    end
    
    def hovedomraader
      @hovedomraader ||= @model.listObjectsOfProperty(@tilhoerer_hovedomraade_property). map do |r|
        {
          :uuid => r.to_s,
          :kode => kode(r),
          :tittel => tittel(r),
        }   
      end.sort{|a, b| a[:tittel] <=> b[:tittel]}
    end
    
    def trinn
      @trinn ||= @model.listObjectsOfProperty(@kompetansemaalsett_etter_aarstrinn_property). map do |r|
        {
          :uuid => r.to_s,
          :tittel => tittel(r)
        }   
      end.sort{|a, b| a[:tittel] <=> b[:tittel]}
    end
    
    private
    
    def uuids(resource, property)
      resource.listProperties(property).map {|p| p.resource.to_s}
    end
    
    def property_content(resource, property)
      r = resource.getProperty(property)
      r.nil? ? "" : r.string
    end
    
    def tittel(resource)
      tittel = property_content(resource, @title_property)
      tittel.blank? ? "mangler tittel" : tittel
    end
    
    def kode(resource)
      property_content(resource, @kode_property)
    end
    
  end
  
end