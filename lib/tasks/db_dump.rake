namespace :db do
  desc "Dumping database to file"
  task :dump => :environment do
    db_name = ActiveRecord::Base.configurations[Rails.env]['database']
    db_user = ActiveRecord::Base.configurations[Rails.env]['username']

    dump_file = File.join(Rails.root, 'tmp', 'kompetansesok_mysql.dump')
    sh "mysqldump -u#{db_user} #{db_name} > #{dump_file}"
  end
end