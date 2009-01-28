module Kompetansesok
  class DbEksport < RunCommand

    @@zip_path = File.join(Rails.root, 'public', 'db_dumps')

    def self.db_name
      ActiveRecord::Base.configurations[Rails.env]['database']
    end
    
    def self.db_user
      ActiveRecord::Base.configurations[Rails.env]['username']
    end

    def self.db_pass_prase
      if ActiveRecord::Base.configurations[Rails.env]['password']
        "-p#{ActiveRecord::Base.configurations[Rails.env]['password']}"
      else
        ""
      end
    end

    def self.eksporter
      dump_filename = 'kompetansesok_mysql.dump'
      dump_filepath = File.join(Rails.root, 'tmp', dump_filename)
      system("mysqldump -u#{db_user} #{db_name} #{db_pass_prase} > #{dump_filepath}")

      
      if not File.exist?(@@zip_path)
        File.makedirs(@@zip_path)
      end

      time_stamp = Time.now.to_datetime.strftime("%d-%m-%Y-%H:%M")
      zip_filename = "db_dump_#{time_stamp}.zip"
      zip_savepath = File.join(@@zip_path, zip_filename)

      require 'zip/zipfilesystem'
      Zip::ZipFile.open(zip_savepath, Zip::ZipFile::CREATE) do |zipfile|
        zipfile.file.open(dump_filename, "w") { |f| f.puts File.new(dump_filepath).read }
      end

      File.delete(dump_filepath)
    end

    def self.cleanup
      if not File.exist?(@@zip_path)
        return
      end

      #TODO fetch this number from the configuration
      keep_number_of_dumps = 3

      existing_dumps = {}
      zip_dir = Dir.new(@@zip_path)
      while(entry =  zip_dir.read)
        if entry =~ /db_dump_(.+)\.zip/
          time_stamp = Time.parse($1)
          existing_dumps[time_stamp] = entry
        end
      end

      old_dump_keys = existing_dumps.keys.sort.reverse.slice(keep_number_of_dumps, existing_dumps.keys.length)

      if old_dump_keys
        old_dump_keys.each do |stamp_key|
          File.delete(File.join(@@zip_path,existing_dumps[stamp_key]))
        end
      end
    end

    def self.restore_backup
      db_dump_zipfile = find_last_db_dump
      db_dump = unzip_db_dump(db_dump_zipfile)
      return DbEksport.new.run_command("mysql -u#{db_user} #{db_name} #{db_pass_prase} < #{db_dump}")
    end

    def self.find_last_db_dump
      time_list = {}
      Dir.entries(@@zip_path).each do |file|
        if file =~ /db_dump_(.*)\.zip/
          time_list[Time.parse($1)]= File.join(@@zip_path, file)
        end
      end

      time_list[time_list.keys.sort.last]
    end

    def self.unzip_db_dump(file)
      require 'zip/zipfilesystem'
      dump_filename = File.join(Rails.root, "tmp", "restore.sql")
      f = File.new(dump_filename, 'w+')

      Zip::ZipFile.open(file) do |zipfile|
        f.puts zipfile.file.read("kompetansesok_mysql.dump")
      end

      f.close
      dump_filename
    end

    
  end
end