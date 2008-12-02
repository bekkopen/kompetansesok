raise "Denne koden krever JRuby" unless defined?(JRUBY_VERSION)
require 'fileutils'
require 'open-uri'
require 'rubygems'
require 'feed_tools'
require 'java'
Dir[File.dirname(__FILE__) + '/../ext/jena-2.5.6/*.jar'].each do |jar|
  require jar
end
JRuby.objectspace = true

module Kompetansesok
  class Jena # TODO: flytt til egen klasse. Enhetstest med RSpec!
    GREP_NS = 'http://psi.udir.no/ontologi/'

    def initialize
      @model = com.hp.hpl.jena.rdf.model.ModelFactory.createDefaultModel
      @kompetansemaal_property = @model.getProperty(GREP_NS, 'kompetansemaalsett_har_kompetansemaal')
      @title_property          = com.hp.hpl.jena.vocabulary.DC_11.title
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
          :title => km.getProperty(@title_property).string
        }
      end
    end
  end

  class Importerer
    ATOM_URL = 'http://lkt.udir.no/eksport/rdf.mvc/laereplan'
    
    # Instansierer ny importerer som henter/leser RDF filer til/fra +import_dir+. Hvis
    # +out+ er spesifisert logges enkel status hit.
    def initialize(import_dir, out=nil)
      @import_dir = import_dir
      @out = out
    end
    
    def slett_filer
      FileUtils.rm_rf(@import_dir)
    end
    
    # Henter +n+ RDF filer fra Atom feed på Internett og lagrer dem lokalt på disk.
    # Hvis +n+ == <tt>nil</tt> hentes alle RDF filer i Atom feeden.
    #
    # Filene som importeres kan senere importeres i databasen via #importer_til_db
    def importer_til_fil(n=nil)
      FileUtils.mkdir_p(@import_dir)

      @out.puts("Leser Atom feed...") if @out
      feed = FeedTools::Feed.open(ATOM_URL)
      entries = n.nil? ? feed.items : feed.items[0...n]
      @out.puts("Importerer #{entries.length} RDF filer...") if @out
      entries.each do |entry|
        @out.write('.') if @out
        if entry.guid =~ /uuid:(.*);id=(.*)/
          id = $2
          jena = Jena.new
          jena.les_rdf_url(entry.link)

          File.open(File.join(@import_dir, "#{id}.rdf"), 'wb') do |f|
            jena.write(f)
          end
        else
          raise "Feil guid format på feed entry: #{entry.guid}"
        end
      end
      @out.puts if @out
    end

    def importer_til_db(n=nil)
      jena = Jena.new
      
      fil_array = n.nil? ? filer : filer[0...n]
      @out.puts("Leser #{fil_array.length} RDF filer...") if @out
      fil_array.each do |rdf_fil|
        @out.write('.') if @out
        jena.les_rdf_fil(rdf_fil)
      end
      @out.puts if @out
      
      jena.kompetansemaal.each do |km|
        @out.puts km[:title] if @out
      end
    end

    def filer
      Dir["#{@import_dir}/*.rdf"]
    end
  end
  
end