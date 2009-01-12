namespace :import do
  desc "Importer data fra features/rdf til db"
  task :db => 'db:migrate' do
    puts "Importerer til #{ENV['RAILS_ENV']}"
    sh('jruby script/import/import_til_db features/rdf')
  end
end