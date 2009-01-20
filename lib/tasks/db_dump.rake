require 'zip/zipfilesystem'


namespace :db do
  desc "Dumping database to file"
  task :dump => :environment do
    begin
      db_name = ActiveRecord::Base.configurations[Rails.env]['database']
      db_user = ActiveRecord::Base.configurations[Rails.env]['username']

      dump_filename = 'kompetansesok_mysql.dump'
      dump_filepath = File.join(Rails.root, 'tmp', dump_filename)
      sh "mysqldump -u#{db_user} #{db_name} > #{dump_filepath}"

      zip_path = File.join(Rails.root, 'public', 'db_dumps')
      if not File.exist?(zip_path)
        File.makedirs(zip_path)
      end

      time_stamp = Time.now.to_datetime.strftime("%d-%m-%Y-%H:%M")
      zip_savepath = File.join(zip_path, "db_dump_#{time_stamp}.zip")

      Zip::ZipFile.open(zip_savepath, Zip::ZipFile::CREATE) do |zipfile|
        zipfile.file.open(dump_filename, "w") { |f| f.puts File.new(dump_filepath).read }
      end

      File.delete(dump_filepath)
    rescue => e
      
      raise e
    end
  end
end