require 'fileutils'
require 'rubygems'
require 'feed_tools'
require 'open-uri'

module Kompetansesok
  class Importerer
    ATOM_URL = 'http://lkt.udir.no/eksport/rdf.mvc/laereplan'
    
    def initialize(import_dir)
      @import_dir = import_dir
    end
    
    def slett_filer
      FileUtils.rm_rf(@import_dir)
    end
    
    def importer_filer(n)
      FileUtils.mkdir_p(@import_dir)

      feed = FeedTools::Feed.open(ATOM_URL)
      feed.items[0...n].each do |entry|
        if entry.guid =~ /uuid:(.*);id=(.*)/
          id = $2
          open(entry.link) do |rdf|
            File.open(File.join(@import_dir, "#{id}.rdf"), 'wb') do |f|
              f.write(rdf.read)
            end
          end
        else
          raise "Feil guid format på feed entry: #{entry.guid}"
        end
      end
    end
    
    def filer
      Dir["#{@import_dir}/*.rdf"]
    end
  end
  
end