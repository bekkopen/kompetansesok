


namespace :db do
  desc "Dumping database to file"
  task :dump => :environment do
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
    zip_filename = "db_dump_#{time_stamp}.zip"
    zip_savepath = File.join(zip_path, zip_filename)

    require 'zip/zipfilesystem'
    Zip::ZipFile.open(zip_savepath, Zip::ZipFile::CREATE) do |zipfile|
      zipfile.file.open(dump_filename, "w") { |f| f.puts File.new(dump_filepath).read }
    end

    File.delete(dump_filepath)
  end

  namespace :cleanup do
    desc "Run clean up of the public/db_dumps"
    task :dumps do
      zip_path = File.join(Rails.root, 'public', 'db_dumps')
      if not File.exist?(zip_path)
        return
      end

      keep_number_of_dumps = 3

      existing_dumps = {}
      zip_dir = Dir.new(zip_path)
      while(entry =  zip_dir.read)
        if entry =~ /db_dump_(.+)\.zip/
          time_stamp = Time.parse($1)
          existing_dumps[time_stamp] = entry
        end
      end

      old_dump_keys = existing_dumps.keys.sort.reverse.slice(keep_number_of_dumps, existing_dumps.keys.length)

      if old_dump_keys
        old_dump_keys.each do |stamp_key|
          File.delete(File.join(zip_path,existing_dumps[stamp_key]))
        end
      end
    end
  end
end
