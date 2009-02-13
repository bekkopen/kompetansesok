module Kompetansesok
  
  class ImportDriver < RunCommand
    
    ULTRASPHINX_INDEXER= "jruby -S rake ultrasphinx:index"

    def initialize(params = {})
      @out        = params[:out]
      @importer   = params[:importer]   || Kompetansesok::Importerer.new(Rails.root + '/tmp/import', $stdout)
      @db_eksport = params[:db_eksport] || Kompetansesok::DbEksport.new
    end

    def run
      @out.puts "Starter planlagt import" if @out
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
      rapport.print "Laster ned rdf data..."
      log = capture_output do
        @importer.importer_til_fil
      end
      rapport.puts " ok"
      rapport.string
    rescue Exception => e
      append_and_raise(e, "Nedlasting av rdf feilet:", log)
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
      append_and_raise(e, "Import til database feilet:", log)
    end

    def haandter_feil_i_import
      rapport = StringIO.new
      rapport.print "Gjenoppretter sikkerhetskopi... "
      log = capture_output do
        @db_eksport.restore_backup
      end
      rapport.puts " ok"
      rapport.puts reindexer
      rapport.string
    rescue => e
      append_and_raise(e, "Forsøket på å rulle backupen tilbake feilet:", log)
    end

    def reindexer
      rapport = StringIO.new
      rapport.print "Reindekserer..."
      log = run_command ULTRASPHINX_INDEXER
      rapport.puts " ok"
      rapport.string
    rescue => e
      append_and_raise(e, "Indeksering feilet:", log)
    end

    def send_rapport(rapport)
      @out.puts rapport if @out
      Kompetansesok::RapportMailer.send_rapport(rapport)
    rescue Exception => e
      #logger feilende mailsending
      @out.puts "Epostsending feilet" if @out
      e.message << "\nEpost mislykket:\n#{e.message}"
      log_file_path = File.join(Rails.root, 'log', 'mail_error.log')
      File.open(log_file_path, 'w+') do |log_file|
        log_file << "\n\n#{Time.now}:\n#{e.mesage}\n"
      end
    end

    def append_and_raise(e, label, log)
      e.message << "\n#{label}\n#{log}"
      raise e
    end
    
  end
end