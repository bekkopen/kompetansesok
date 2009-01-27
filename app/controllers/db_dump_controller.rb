class DbDumpController < ApplicationController
  def index
    if File.directory?(Udir::DB_DUMP_PATH)
      @db_dumps = Dir["#{Udir::DB_DUMP_PATH}/*.zip"].map{|path| path[Rails.public_path.length+1..-1]}
      @db_dumps.sort.reverse!
    else
      @db_dumps = []
    end
  end
end
