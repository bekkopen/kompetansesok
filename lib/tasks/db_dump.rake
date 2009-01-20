require 'zip/zipfilesystem'


namespace :db do
  desc "Dumping database to file"
  task :dump => :environment do
    db_name = ActiveRecord::Base.configurations[Rails.env]['database']
    db_user = ActiveRecord::Base.configurations[Rails.env]['username']

    dump_filename = 'kompetansesok_mysql.dump'
    dump_filepath = File.join(Rails.root, 'tmp', dump_filename)
    sh "mysqldump -u#{db_user} #{db_name} > #{dump_filepath}"

    puts "Database writen to #{dump_filepath}"

    zip_path = File.join(Rails.root, 'public', 'db_dumps')
    if not File.exist?(zip_path)
      File.makedirs(zip_path)
    end

    Zip::ZipFile.open(File.join(zip_path, "db_dump.zip"), Zip::ZipFile::CREATE) do |zipfile|
      zipfile.file.open(dump_filename, "w") { |f| f.puts File.new(dump_filepath).read }
    end

  end
end