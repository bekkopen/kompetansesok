if defined?(JRUBY_VERSION)
  begin
    begin
      # First, make sure plugin directory is at the front of the load path
      # (to avoid picking up gem-installed warbler)
      require 'warbler'
    rescue LoadError
      # Next, try activating the gem
      gem 'warbler'
      require 'warbler'
    end

    Warbler::Task.new
  rescue Exception => e
    # Ignore - happens when we're in a War - warbler isn't packaged
  end
end

task :clean_war => ['clobber', 'submodules:install', 'war']

namespace :war do
  desc "create production war"
  task :production do
    sh('jruby -S rake clean_war RAILS_ENV=production SKIP_SETUP_DATA=true')
  end
   
end
  
  