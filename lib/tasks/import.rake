namespace :import do
  task :data => [:db, 'ultrasphinx:index']
  
  desc "Importer data fra features/rdf til db"
  task :db => 'db:migrate' do
    puts "Importerer til #{ENV['RAILS_ENV']}"
    sh('jruby script/import/import_til_db features/rdf')
  end

  task :rdf_fetch do
    require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
    Kompetansesok::ImportDriver.new({:out => $stdout}).run
  end

  desc "Henter RDF fra GREP, importer til DB og rapporterer status via epost"
  task :scheduled_import do
	puts "STOP..."
	system "net.exe stop SphinxKompetansesok"
	puts "IMPORT..."
	Rake::Task['import:rdf_fetch'].invoke
	puts "START..."
	system "net.exe start SphinxKompetansesok"
  end
end