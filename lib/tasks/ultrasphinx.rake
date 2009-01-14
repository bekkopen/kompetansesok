namespace :db do
  # Vi legger til ekstra for å sette opp ultrasphinx
  task :migrate => 'ultrasphinx:configure'
  
  namespace :test do
    # For at specs skal ha tilgjengelig indeksert data må vi gjøre dette her.
    task :prepare do
      Rake::Task['ultrasphinx:index'].invoke
    end
  end
end
