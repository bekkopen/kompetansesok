module Kompetansesok
  class DbEksport < RunCommand
    def db_name
      ActiveRecord::Base.configurations[Rails.env]['database']
    end

    def db_user
      ActiveRecord::Base.configurations[Rails.env]['username']
    end

    def db_pass_prase
      if ActiveRecord::Base.configurations[Rails.env]['password']
        "-p#{ActiveRecord::Base.configurations[Rails.env]['password']}"
      else
        ""
      end
    end

    def eksporter
      dump_filename = 'kompetansesok_mysql.dump'
      dump_filepath = File.join(Rails.root, 'tmp', dump_filename)
      run_command("mysqldump -u#{db_user} #{db_name} #{db_pass_prase} > #{dump_filepath}")

      time_stamp = Time.now.to_datetime.strftime("%d%m%Y%H%M")
      zip_filename = "db_dump_#{time_stamp}.zip"
      zip_savepath = File.join(Udir::DB_DUMP_PATH, zip_filename)

      require 'zip/zipfilesystem'
      Zip::ZipFile.open(zip_savepath, Zip::ZipFile::CREATE) do |zipfile|
        zipfile.file.open(dump_filename, "w") { |f| f.puts File.new(dump_filepath).read }
      end

      File.delete(dump_filepath)
    end

    def cleanup
      existing_dumps = {}
      zip_dir = Dir.new(Udir::DB_DUMP_PATH)
      
      while(entry =  zip_dir.read)
        if entry =~ /db_dump_(.+)\.zip/
          time_stamp = ($1)
          existing_dumps[time_stamp] = entry
        end
      end
      
      old_dump_keys = existing_dumps.keys.sort.reverse.slice(Udir::DUMP_COUNT, existing_dumps.keys.length)

      if old_dump_keys
        old_dump_keys.each do |stamp_key|
          File.delete(File.join(Udir::DB_DUMP_PATH, existing_dumps[stamp_key]))
        end
      end
    end

    def restore_backup
      db_dump_zipfile = find_last_db_dump
      db_dump = unzip_db_dump(db_dump_zipfile)
      run_command("mysql -u#{db_user} #{db_name} #{db_pass_prase} < #{db_dump}")
    end

    def find_last_db_dump
      time_list = {}
      Dir.entries(Udir::DB_DUMP_PATH).each do |file|
        if file =~ /db_dump_(.*)\.zip/
          time_list[($1)]= File.join(Udir::DB_DUMP_PATH, file)
        end
      end

      time_list[time_list.keys.sort.last]
    end

    def unzip_db_dump(file)
      require 'zip/zipfilesystem'
      dump_filename = File.join(Rails.root, "tmp", "restore.sql")
      
      if not File.exist?(file)
        raise "Ingen fil med navn: #{file}"
      end

      f = File.new(dump_filename, 'w+')

      Zip::ZipFile.open(file) do |zipfile|
        f.puts zipfile.file.read("kompetansesok_mysql.dump")
      end

      f.close
      dump_filename
    end
  end
end