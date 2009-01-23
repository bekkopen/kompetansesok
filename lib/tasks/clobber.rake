desc 'Clobber all generated files'
task :clobber => ['war:clean', 'log:clear', 'tmp:clear', 'tmp:create'] do
  sh 'git clean -f -d'
  FileUtils.rm('config/ultrasphinx/development.conf', 'config/ultrasphinx/test.conf', 'config/ultrasphinx/integration_test.conf')
  FileUtils.rm_rf(Dir['tmp/sphinx*'])
end