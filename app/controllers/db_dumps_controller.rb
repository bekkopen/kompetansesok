class DbDumpsController < ApplicationController
  def index
    @db_dumps = {}
    @db_dumps_dir = udir_config['db_dumps']['path']
    
    all_db_dump_files = Dir.new(@db_dumps_dir)


    @dir_name = last_dir_of_path @db_dumps_dir
    
    while(db_dump_filename = all_db_dump_files.read)
      if db_dump_filename =~ /db_dump_.+\.zip/
        @db_dumps[db_dump_filename] = File.join(@dir_name, db_dump_filename)
      end
    end
  end

  private
  def last_dir_of_path(path)
    if path =~ /.*\/(.*)/
      $1
    else
      ""
    end
  end
end
