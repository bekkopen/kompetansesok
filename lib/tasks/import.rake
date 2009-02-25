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
  task :scheduled_import_win do
    system "net.exe stop SphinxKompetansesok"
    begin 
      Rake::Task['import:rdf_fetch'].invoke
    ensure
      system "net.exe start SphinxKompetansesok"
    end
  end
end