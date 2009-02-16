desc 'Clobber all generated files'
task :clobber => ['war:clean', 'log:clear', 'tmp:clear', 'tmp:create'] do
  sh 'git clean -f -d'
  %w{development test integration_test}.each do |env|
    FileUtils.rm("config/ultrasphinx/#{env}.conf") rescue nil
  end
  FileUtils.rm_rf('tmp/import')
end