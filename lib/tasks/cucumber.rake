$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    desc "Cucumber features for import (JRuby)"
    Cucumber::Rake::Task.new(:alt) do |t|
      t.cucumber_opts = "--profile alt"
    end
    task :alt => 'db:test:prepare'

    desc "Cucumber features for app (JRuby/MRI)"
    Cucumber::Rake::Task.new(:app) do |t|
      t.cucumber_opts = "--profile app"
    end
    task :app => 'db:test:prepare'
  end
rescue LoadError
  STDERR.puts "**** Ikke glem gem install cucumber ****"
end