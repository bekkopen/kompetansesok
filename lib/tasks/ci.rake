namespace :ci do
  desc "Kjør alle tester"
  task :all => 'db:migrate' do
    sh("jruby -S rake spec")
    sh("rake import:db features:app")
    sh("jruby -S rake features:import")
  end
end