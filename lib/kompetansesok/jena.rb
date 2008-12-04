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
      @kode_property                                = @model.getProperty(GREP_NS, 'kode')
      @kompetansemaal_property                      = @model.getProperty(GREP_NS, 'kompetansemaalsett_har_kompetansemaal')
      @kompetansemaalsett_etter_laereplan_property  = @model.getProperty(GREP_NS, 'kompetansemaalsett_etter_laereplan')        
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
      @model.listResourcesWithProperty(@kompetansemaal_property).map do |km|
        {
          :tittel => km.getProperty(@title_property).string
        }
      end
    end
    
    def laereplaner
      @model.listObjectsOfProperty(@kompetansemaalsett_etter_laereplan_property).map do |r|
        { 
          :uuid => r.to_s,
          :kode => r.getProperty(@kode_property).string,
          :tittel => r.getProperty(@title_property).string
        }
      end
    end
  end
  
end