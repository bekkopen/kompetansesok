require File.dirname(__FILE__) + '/inflections'
load File.dirname(__FILE__) + '/../../Rakefile'

if Rails.env == 'production' && defined?(JRUBY_VERSION) # Vi er på Glassfish!
  class SetupData
    def opprett_tabeller
      puts "== OPPRETTER DATABASETABELLER =="
      migrations = File.expand_path(File.dirname(__FILE__) + '/../../db/migrate')
      ActiveRecord::Migrator.migrate(migrations)
    end
    
    def konfig_sphinx
      puts "== OPPRETTER SPHINX KONFIGURASJON =="
      Rake::Task["ultrasphinx:configure"].invoke
    end
    
    def import_rdf
      puts "== IMPORTERER RDF =="
      statiske_rdf_filer = File.expand_path(File.dirname(__FILE__) + '/../../features/rdf')
      importerer = Kompetansesok::Importerer.new(statiske_rdf_filer, STDOUT)
      importerer.importer_til_db
    end
    
    def index_data
      puts "== INDEKSERER DATA =="
      Rake::Task["ultrasphinx:index"].invoke  
    end
    
    def restart_sphinx
      begin
        puts "== RESTARTER SPHINX DAEMON =="
        Rake::Task["ultrasphinx:daemon:restart"].invoke
      rescue
        puts "== STARTER SPHINX DAEMON =="
        Rake::Task["ultrasphinx:daemon:start"].invoke
      end
    end
  end

  sd = SetupData.new
  sd.opprett_tabeller
  sd.konfig_sphinx
  sd.import_rdf
  sd.index_data
  sd.restart_sphinx

  puts "== KLAR =="
end