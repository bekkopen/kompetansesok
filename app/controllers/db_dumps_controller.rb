class DbDumpsController < ApplicationController
  def index
    @db_dumps = {}
    
    @db_dumps_dir = udir_config['db_dumps']['path']
    
    all_db_dump_files = Dir.new(@db_dumps_dir)
    while(db_dump_filename = all_db_dump_files.read)
      if db_dump_filename =~ /db_dump_.+\.zip/
        @db_dumps[db_dump_filename] = File.join("db_dumps", db_dump_filename)
      end
     end
  end
end
