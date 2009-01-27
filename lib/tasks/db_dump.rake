


namespace :db do
  desc "Dumping database to file"
  task :dump => :environment do
    Kompetansesok::DbEksport.eksporter
  end

  namespace :cleanup do
    desc "Run clean up of the public/db_dumps"
    task :dumps => :environment do
      Kompetansesok::DbEksport.cleanup
    end
  end
end
