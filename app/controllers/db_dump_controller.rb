class DbDumpController < ApplicationController
  def index
    if File.directory?(Udir::DB_DUMP_PATH)
      file_name_start_at_index = if defined?($servlet_context)
        Rails.public_path.length
      else
        Rails.public_path.length+1
      end
      @db_dumps = Dir["#{Udir::DB_DUMP_PATH}/*.zip"].map{|path| path[file_name_start_at_index..-1]}
      @db_dumps.sort!
      @db_dumps.reverse!
    else
      @db_dumps = []
    end
  end
end
