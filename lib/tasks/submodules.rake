namespace :submodules do

  desc 'Installerer ultrashpinx submodule'
  task :install do
    sh('git submodule init')
    sh('git submodule update')
  end
end