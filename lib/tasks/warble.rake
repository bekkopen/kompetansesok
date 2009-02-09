if defined?(JRUBY_VERSION)
  gem 'aslakhellesoy-warbler'
  require 'warbler'

  Warbler::Task.new
end

namespace :war do
  desc "create production war"
  task :production do
    sh('jruby -S rake clobber submodules:install RAILS_ENV=production SKIP_SETUP_DATA=true')
    sh('jruby -S rake war RAILS_ENV=production SKIP_SETUP_DATA=true')
  end
   
end
  
  