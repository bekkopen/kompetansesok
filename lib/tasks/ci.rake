namespace :ci do
  desc "Kjør de raske testene"
  task :quick => ['log:clear', 'db:migrate'] do
    sh("jruby -S rake spec")
    sh("rake features:app RAILS_ENV=integration_test")
  end

  desc "Kjør de trege testene"
  task :slow => ['log:clear'] do
    sh("rake db:migrate import:data RAILS_ENV=integration_test")
    sh("jruby -S rake features:import RAILS_ENV=test")
  end
end