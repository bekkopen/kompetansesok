raise "Denne koden krever JRuby" unless defined?(JRUBY_VERSION)
require 'fileutils'
require 'open-uri'
require 'rubygems'
require 'feed_tools'
require 'java'

JRuby.objectspace = true

module Kompetansesok

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

      importer_laereplaner(jena)
      importer_kompetansemaalsett(jena)
      importer_kompetansemaal(jena)
    end

    def filer
      Dir["#{@import_dir}/*.rdf"]
    end
    
    private
    
    def importer_laereplaner(jena)
      laereplaner = jena.laereplaner || []
      laereplaner.each do |r|
        Laereplan.create!(r)      
      end
    end
  
    def importer_kompetansemaalsett(jena)
      maalsett = jena.kompetansemaalsett || []
      maalsett.each do |r|
        laereplan_uuid = r.delete(:laereplan_uuid)
        k = Kompetansemaalsett.new(r)
        k.laereplan = Laereplan.find_by_uuid(laereplan_uuid)
        k.save!
      end
    end

    def importer_kompetansemaal(jena)
      kompetansemaal = jena.kompetansemaal || []
      kompetansemaal.each do |r|
        kompetansemaalsett_uuid = r.delete(:kompetansemaalsett_uuid)
        k = Kompetansemaal.new(r)
        k.kompetansemaalsett = Kompetansemaalsett.find_by_uuid(kompetansemaalsett_uuid)
        k.save!
      end
    end
    
  end
 
end