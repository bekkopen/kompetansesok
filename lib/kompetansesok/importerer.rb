require 'fileutils'
require 'open-uri'
require 'rubygems'
require 'feed_tools'
JRuby.objectspace = true if defined?(JRUBY_VERSION)

module Kompetansesok
  class Importerer
    ATOM_URL = 'http://lkt.udir.no/eksport/rdf.mvc/laereplan'
    
    def initialize(import_dir = Rails.root + '/tmp/import')
      @import_dir = import_dir
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

      feed = FeedTools::Feed.open(ATOM_URL)
      entries = n.nil? ? feed.items : feed.items[0...n]
      entries.each do |entry|
        if entry.guid =~ /uuid:(.*);id=(.*)/
          id = $2
          open(entry.link) do |rdf|
            File.open(File.join(@import_dir, "#{id}.rdf"), 'wb') do |f|
              f.write(rdf.read)
            end
          end
        else
          raise "Feil guid format på feed entry: #{entry.guid}"
        end
      end
    end

    def importer_til_db(n=nil)
      require 'java'
      Dir[File.dirname(__FILE__) + '/../ext/jena-2.5.6/*.jar'].each do |jar|
        require jar
      end

      model = com.hp.hpl.jena.rdf.model.ModelFactory.createDefaultModel

      grep = 'http://psi.udir.no/ontologi/'
      kompetansemaal_property = model.getProperty(grep, 'kompetansemaalsett_har_kompetansemaal')
      title_property          = com.hp.hpl.jena.vocabulary.DC_11.title

      fa = n.nil? ? filer : filer[0...n]
      fa.each do |rdf|
        fm = com.hp.hpl.jena.util.FileManager.get.open(rdf)
        model.read(fm, "")
      end
      model.listResourcesWithProperty(kompetansemaal_property).each do |res|
        #puts res.getProperty(title_property).string
      end
    end

    def filer
      Dir["#{@import_dir}/*.rdf"]
    end
  end
  
end