module Kompetansesok
  
  class ImportDriver < RunCommand
    
    ULTRASPHINX_INDEXER= "jruby -S rake ultrasphinx:index"

    def initialize(params)
      @importer   = params[:importer]   || Kompetansesok::Importerer.new(Rails.root + '/tmp/import', $stdout)
      @db_eksport = params[:db_eksport] || Kompetansesok::DbEksport.new
    end

    def run
      rapport = StringIO.new
      rapport.puts lastned_filer
      rapport.puts importer_til_database
      rapport.puts reindexer
      
      rapport.puts "Planlagt import og reindexering er velykket"
      send_rapport(rapport.string)
    rescue Exception => e
      rapport.puts(e)
      send_rapport rapport.string
      raise rapport.string
    end
    
    def lastned_filer
      rapport = StringIO.new
      begin
        rapport.print "Laster ned rdf data..."
        log = capture_output do
          @importer.importer_til_fil
        end
        rapport.puts " ok"
      rescue => e
        rapport.puts "\nNedlasting av rdf feilet: #{e}"
        if(log && !log.empty?)
          rapport.puts "Historie: #{log.read}" if not log.strin.empty?
        end
        rapport.puts e
        raise rapport.string
      end

      rapport.string
    end

    def importer_til_database
      rapport = StringIO.new
      rapport.print "Importerer til database.."
      log = capture_output do
        @importer.importer_til_db
      end
      rapport.puts " ok"
      rapport.string
    rescue Exception => e
      rapport.puts "\nImport til database feilet: #{e}"
      if(log && !log.empty?)
        rapport.puts "Historie: #{log.read}"
      end

      rapport.puts haandter_feil_i_import

      rapport.puts e
      raise rapport.string
    end

    def haandter_feil_i_import
      rapport = StringIO.new
      rapport.print "Restoring backup... "
      log = capture_output do
        @db_eksport.restore_backup
      end
      rapport.puts " ok"
      rapport.puts reindexer
      rapport.string
    rescue => e
      rapport.puts "\nForsøket på å rulle backupen tilbake feilet: #{e}"
      if(log && !log.empty?)
        rapport.puts "Historie: #{log.read}" 
      end
      rapport.puts e
      raise rapport.string
    end

    def reindexer()
      rapport = StringIO.new
      rapport.print "Gjør reindexsering..."
      log = run_command ULTRASPHINX_INDEXER
      rapport.puts " ok"
      rapport.string
    rescue => e
      rapport.puts "\nIndexeringen feilet: #{e}"
      rapport.puts "Historie: #{log}" if not log.empty?
      rapport.puts e
      raise rapport.string
    end

    def send_rapport(rapport)
      Kompetansesok::RapportMailer.send_rapport(rapport)
    end

  end
end