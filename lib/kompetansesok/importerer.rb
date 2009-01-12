raise "Denne koden krever JRuby" unless defined?(JRUBY_VERSION)
require 'fileutils'
require 'open-uri'
require 'rubygems'
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
    
    # Henter +n+ RDF filer fra Atom feed på Internett og lagrer dem lokalt på disk.
    # Hvis +n+ == <tt>nil</tt> hentes alle RDF filer i Atom feeden.
    #
    # Filene som importeres kan senere importeres i databasen via #importer_til_db
    def importer_til_fil(n=nil)
      require 'feed_tools' # Vi aktiverer kun koden her fordi den monkey patcher YAML til å bruke YAML.parser (finnes ikke i JRuby)
      FileUtils.rm_rf(@import_dir)
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

      ActiveRecord::Base.transaction do
        @out.puts('Sletter gamle data...') if @out
        Kompetansemaal.delete_all
        Kompetansemaalsett.delete_all
        Laereplan.delete_all
        Hovedomraade.delete_all
        Trinn.delete_all

        @out.puts("Importerer #{jena.trinn.length} Trinn...") if @out
        Trinn.create!(jena.trinn)
        @out.puts("Importerer #{jena.laereplaner.length} Laereplan...") if @out
        Laereplan.create!(jena.laereplaner)
        @out.puts("Importerer #{jena.hovedomraader.length} Hovedomraade...") if @out
        Hovedomraade.create!(jena.hovedomraader)
        @out.puts("Importerer #{jena.kompetansemaalsett.length} Kompetansemaalsett...") if @out
        Kompetansemaalsett.create!(jena.kompetansemaalsett)
        @out.puts('Database commit...') if @out
      end
      
      @out.puts("Importerer #{jena.kompetansemaal.length} Kompetansemaal...") 
      require 'progressbar'
      pbar = ProgressBar.new("Import", jena.kompetansemaal.length, @out)
      
      batch_size = 500
      n = 0
      loop do
        batch = jena.kompetansemaal[n...n+batch_size]
        break if batch.nil?
        
        ActiveRecord::Base.transaction do
          Kompetansemaal.create!(batch)
          pbar.inc(batch.length)
        end
        n += batch_size
      end
      pbar.finish
      
      @out.puts('Import ferdig.') if @out
    end

    def filer
      Dir["#{@import_dir}/*.rdf"].sort
    end
  end 
end