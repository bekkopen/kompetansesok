raise "Denne koden krever JRuby" unless defined?(JRUBY_VERSION)
require 'fileutils'
require 'open-uri'
require 'rubygems'
require 'java'
require "atom/feed"

JRuby.objectspace = true

module Kompetansesok

  class Importerer
    INGEN_FORANDRING = "ingen_forandring"
    IMPORT_GJORDT = "import_gjordt"
    
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

    def importer_til_db(antall_filer=nil)
      @jena = Jena.new
      if new_rdf_data?
        les_filer(antall_filer)
        slett_alt_i_databasen
        last_inn_kompetansemaal
        last_inn(Trinn, Fag, Kompetansemaalsett, Hovedomraade, Laereplan)
        RdfMd5Sum.current = md5sum_av_leste_filer
        @out.puts('Import ferdig.') if @out

        lag_db_dump
        IMPORT_GJORDT
      else
        @out.puts('Intet behov for å lese in data, ingen edringer på rdfene') if @out
        INGEN_FORANDRING
      end
    end

    def lag_db_dump
      @out.puts('Gjør db eksport og cleanup') if @out
      Kompetansesok::DbEksport.new.eksporter
      Kompetansesok::DbEksport.new.cleanup
      @out.puts('Export og clean up ferdig') if @out
    end

    def filer
      Dir["#{@import_dir}/*.rdf"].sort
    end
    
    def les_filer(antall=nil)
      fil_array = antall.nil? ? filer : filer[0...antall]
      @out.puts("Leser #{fil_array.length} RDF filer...") if @out
      fil_array.each do |rdf_fil|
        @out.write('.') if @out
        @jena.les_rdf_fil(rdf_fil)
      end
    end

    def md5sum_av_leste_filer(antall=nil)
      stream = StringIO.new

      fil_array = antall.nil? ? filer : filer[0...antall]
      fil_array.each do |rdf_fil|
        stream << File.open(rdf_fil, 'r').read
      end

      Digest::MD5.md5(stream.string).to_s
    end

    def new_rdf_data?
      md5sum_av_leste_filer != RdfMd5Sum.current
    end

    private

    def slett_alt_i_databasen
      ActiveRecord::Base.transaction do
        @out.print("\nSletter gamle data...") if @out
        Laereplan.destroy_all
        Hovedomraade.destroy_all
        Kompetansemaalsett.destroy_all
        Fag.destroy_all
        Trinn.destroy_all
        Kompetansemaal.destroy_all
        @out.print('Commit...') if @out
      end
      @out.puts('OK!') if @out
    end
    
    def last_inn_kompetansemaal
      if @out
        @out.puts("Importerer #{@jena.kompetansemaal.length} Kompetansemaal...")
        require 'progressbar'
        pbar = ProgressBar.new("Import", @jena.kompetansemaal.length, @out)
      end
       
      batch_size = 500
      n = 0
      loop do
        batch = @jena.kompetansemaal[n...n+batch_size]
        break if batch.nil?
        
        ActiveRecord::Base.transaction do
          Kompetansemaal.create!(batch)
          if @out
            pbar.inc(batch.length) 
            @out.flush
          end
        end
        n += batch_size
      end

      pbar.finish if @out
    end
    
    def last_inn(*typer)
      ActiveRecord::Base.transaction do
        typer.each do |type|
          data = @jena.send(type.name.pluralize.downcase)
          @out.print("Importerer #{data.length} #{type.name.pluralize}...") if @out
          type.create!(data)
          @out.puts('OK!') if @out
        end
        @out.print('Commit...') if @out
      end
      @out.puts('OK!') if @out
    end
    
  end
end