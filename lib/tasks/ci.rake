namespace :ci do
  desc "Kjør alle tester"
  task :all => 'db:migrate' do
    sh("jruby -S rake spec")
    sh("jruby -S rake features:import")
    sh("rake import:db features:app")
  end
end