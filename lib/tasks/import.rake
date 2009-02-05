namespace :import do
  task :data => [:db, 'ultrasphinx:index']
  
  desc "Importer data fra features/rdf til db"
  task :db => 'db:migrate' do
    puts "Importerer til #{ENV['RAILS_ENV']}"
    sh('jruby script/import/import_til_db features/rdf')
  end

  desc "Task som gjør henting, import og status rapportering"
  task :scheduled_import do
    require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
    Kompetansesok::ImportDriver.new({:out => $stdout}).run
  end

end