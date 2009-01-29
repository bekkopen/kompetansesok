module Kompetansesok
  
  class ImportDriver < RunCommand
    
    ULTRASPHINX_INDEXER= "jruby -S rake ultrasphinx:index"

    def initialize(params)
      @importer   = params[:importer]   || Kompetansesok::Importerer.new(Rails.root + '/tmp/import', $stdout)
      @db_eksport = params[:db_eksport] || Kompetansesok::DbEksport.new
    end

    def run
      lastned_filer
      importer_til_database
      reindexer
      
      puts "Planlagt import og reindexering er velykket"
    end
    
    def lastned_filer
      begin
        print "Laster ned rdf data..."
        log = capture_output do
          @importer.importer_til_fil
        end
        puts " ok"
      rescue => e
        puts "\nNedlasting av rdf feilet: #{e}"
        if(log && !log.empty?)
          puts "Historie: #{log.readlines.join('\n')}"
        end
        raise e
      end
    end

    def importer_til_database
      
      print "Importerer til database.."
      log = capture_output do
        @importer.importer_til_db
      end
      puts " ok"
    rescue Exception => e
      puts "\nImport til database feilet: #{e}"
      if(log && !log.empty?)
        puts "Historie: #{log.readlines.join('\n')}"
      end

      haandter_feil_i_import

      raise e
    end

    def haandter_feil_i_import
      print "Restoring backup... "
      log = capture_output do
        @db_eksport.restore_backup
      end
      puts " ok"
      reindexer
    rescue => e
      puts "\nForsøket på å rulle backupen tilbake feilet: #{e}"
      if(log && !log.empty?)
        puts "Historie: #{log.readlines.join('\n')}"
      end
      raise e
    end

    def reindexer()
      
      print "Gjør reindexsering..."
      log = run_command ULTRASPHINX_INDEXER
      puts " ok"
    rescue => e
      puts "\nIndexeringen feilet: #{e}"
      puts "Historie: #{log}"
      raise e
    end

  end
end