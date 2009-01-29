$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
begin
  require 'cucumber/rake/task'

  namespace :features do
    desc "Cucumber features for import (JRuby)"
    Cucumber::Rake::Task.new(:import) do |t|
      t.cucumber_opts = "--profile import"
      # TODO - dette burde ikke være nødvendig - fikse i Cucumber
      t.feature_pattern = "import_features/**/*.feature"
      t.step_pattern = "import_features/**/*.rb"
    end
    if ENV["FASTER"] != "true"
      task :import => 'db:test:prepare'
    else
      task :import
    end

    desc "Cucumber features for app (MRI)"
    Cucumber::Rake::Task.new(:app) do |t|
      t.cucumber_opts = "--profile app"
    end
  end
rescue LoadError
  STDERR.puts "**** Ikke glem gem install cucumber ****"
end