if defined?(JRUBY_VERSION)
  gem 'aslakhellesoy-warbler'
  require 'warbler'

  Warbler::Task.new
end

task :clean_war => ['clobber', 'submodules:install', 'war']

namespace :war do
  desc "create production war"
  task :production do
    sh('jruby -S rake clean_war RAILS_ENV=production SKIP_SETUP_DATA=true')
  end
   
end
  
  