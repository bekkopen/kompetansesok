require File.dirname(__FILE__) + '/inflections'
load File.dirname(__FILE__) + '/../../Rakefile'

if Rails.env == 'production' && defined?(JRUBY_VERSION)
  puts "== OPPRETTER DATABASETABELLER =="
  migrations = File.expand_path(File.dirname(__FILE__) + '/../../db/migrate')
  ActiveRecord::Migrator.migrate(migrations)

  puts "== OPPRETTER SPHINX KONFIGURASJON =="
  Rake::Task["ultrasphinx:configure"].invoke

  puts "== IMPORTERER RDF =="
  # statiske_rdf_filer = File.expand_path(File.dirname(__FILE__) + '/../../features/rdf')
  # importerer = Kompetansesok::Importerer.new(statiske_rdf_filer, STDOUT)
  # importerer.importer_til_db

  puts "== INDEKSERER DATA =="
  Rake::Task["ultrasphinx:index"].invoke  

  begin
    puts "== RESTARTER SPHINX DAEMON =="
    Rake::Task["ultrasphinx:daemon:restart"].invoke
  rescue
    puts "== STARTER SPHINX DAEMON =="
    Rake::Task["ultrasphinx:daemon:start"].invoke
  end

  puts "== KLAR =="
end