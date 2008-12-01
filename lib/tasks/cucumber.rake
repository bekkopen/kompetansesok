$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
require 'cucumber/rake/task'

namespace :features do
  Cucumber::Rake::Task.new(:import) do |t|
    t.cucumber_opts = "--language no"
  end

  Cucumber::Rake::Task.new(:sok) do |t|
    t.cucumber_opts = "--language no"
  end

  task :sok => 'db:test:prepare'
end