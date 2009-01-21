desc 'Clobber all generated files'
task :clobber => ['war:clean', 'log:clear', 'tmp:clear', 'tmp:create'] do
  sh 'git clean -f -d'
  FileUtils.rm(Dir['config/ultrasphinx/*.conf'])
  FileUtils.rm_rf(Dir['tmp/sphinx*'])
end