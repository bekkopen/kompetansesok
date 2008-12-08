namespace :ci do
  desc "Kjør alle tester"
  task :all do
    sh("jruby -S rake spec")
    sh("jruby -S rake features:import")
    sh("rake import:db features:app")
  end
end