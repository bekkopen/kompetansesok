raise "Denne koden krever JRuby" unless defined?(JRUBY_VERSION)
require 'fileutils'
require 'open-uri'
require 'rubygems'
require 'java'
require "atom/feed"

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
      
      
      FileUtils.rm_rf(@import_dir)
      FileUtils.mkdir_p(@import_dir)

      @out.puts("Leser Atom feed...") if @out
      feed = Atom::Feed.new(ATOM_URL)
      feed.update!

      entries = n.nil? ? feed.entries : feed.entries[0...n]
      @out.puts("Importerer #{entries.length} RDF filer...") if @out
      entries.each do |entry|
        @out.write('.') if @out
        if entry.id =~ /uuid:(.*);id=(.*)/
          id = $2
          jena = Jena.new
          jena.les_rdf_url(entry.links.last.href)

          File.open(File.join(@import_dir, "#{id}.rdf"), 'wb') do |f|
            jena.write(f)
          end
        else
          raise "Feil id format på feed entry: #{entry.id}"
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
        Fag.delete_all
        Laereplan.delete_all
        Hovedomraade.delete_all
        Trinn.delete_all

        @out.puts("Importerer #{jena.trinn.length} Trinn...") if @out
        Trinn.create!(jena.trinn)
        @out.puts("Importerer #{jena.hovedomraader.length} Hovedomraade...") if @out
        Hovedomraade.create!(jena.hovedomraader)
        @out.puts("Importerer #{jena.laereplaner.length} Laereplan...") if @out
        Laereplan.create!(jena.laereplaner)
        @out.puts("Importerer #{jena.fag.length} Fag...") if @out
        Fag.create!(jena.fag)
        @out.puts("Importerer #{jena.kompetansemaalsett.length} Kompetansemaalsett...") if @out
        Kompetansemaalsett.create!(jena.kompetansemaalsett)
        @out.puts('Database commit...') if @out
      end
      
      if @out
        @out.puts("Importerer #{jena.kompetansemaal.length} Kompetansemaal...")
        require 'progressbar'
        pbar = ProgressBar.new("Import", jena.kompetansemaal.length, @out)
      end
       
      batch_size = 500
      n = 0
      loop do
        batch = jena.kompetansemaal[n...n+batch_size]
        break if batch.nil?
        
        ActiveRecord::Base.transaction do
          Kompetansemaal.create!(batch)
          pbar.inc(batch.length) if @out
        end
        n += batch_size
      end
      pbar.finish if @out
      
      @out.puts('Import ferdig.') if @out
    end

    def filer
      Dir["#{@import_dir}/*.rdf"].sort
    end
  end 
end