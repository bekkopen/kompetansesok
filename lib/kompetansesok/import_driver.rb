module Kompetansesok
  
  class ImportDriver
    ULTRASPHINX_INDEXER= "jruby -S rake ultrasphinx:index"


    def initialize(params)
      if(params[:importer])
        @importer = params[:importer]
      else
        @importer = Kompetansesok::Importerer.new(Rails.root + '/tmp/import', $stdout)
      end

      begin
        require 'stringio'
      rescue => e
        puts "Oppstart av skedulert_import feilet: #{e}"
      end
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
        restore_backup
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

    def restore_backup
      db_dump_zipfile = find_last_db_dump
      db_dump = unzip_db_dump(db_dump_zipfile)
      return run_command("mysql -uroot kompetansesok < #{db_dump}")
    end

    def find_last_db_dump
      db_dumps_path = File.join(Rails.root, "public", "db_dumps")
      time_list = {}
      Dir.entries(db_dumps_path).each do |file|
        if file =~ /db_dump_(.*)\.zip/
          time_list[Time.parse($1)]= File.join(db_dumps_path, file)
        end
      end

      time_list[time_list.keys.sort.last]
    end

    def unzip_db_dump(file)
      require 'zip/zipfilesystem'
      dump_filename = File.join(Rails.root, "tmp", "restore.sql")
      f = File.new(dump_filename, 'w+')

      Zip::ZipFile.open(file) do |zipfile|
        f.puts zipfile.file.read("kompetansesok_mysql.dump")
      end

      f.close
      dump_filename
    end

    #runs the given block, and returns the block output to stdout
    def capture_output(&proc)
      log = StringIO.new
      old_stdout = $stdout
      $stdout = log
      proc.call
      log.read
    rescue Exception => e
      e.message << "Historie: #{log.read}" if log.size != 0
      raise e
    ensure
      $stdout = old_stdout
    end

    #kaster exception hvis kommandoen feiler, returnerer utskriften fra funksjonen
    def run_command(command)
      tekst= capture_output do
        return_value = system(command)
        if return_value == false
          raise "Kunne ikke kjøre '#{command}'; feil:#{$?}"
        end
      end

      if tekst =~ /ERROR/
        raise "Kunne ikke kjøre '#{command}'; feil:#{tekst}"
      end

      tekst
    end
  end
end