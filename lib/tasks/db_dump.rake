namespace :db do
  desc "Dumping database to file"
  task :dump => :environment do
    Kompetansesok::DbEksport.new.eksporter
  end

  namespace :cleanup do
    desc "Run clean up of the public/db_dumps"
    task :dumps => :environment do
      Kompetansesok::DbEksport.new.cleanup
    end
  end
end
