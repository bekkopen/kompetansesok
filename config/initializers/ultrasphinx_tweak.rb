require 'rbconfig'
if Rails.env == 'production' && defined?(JRUBY_VERSION) && !(Config::CONFIG['host_os'] =~ /mswin|mingw/)
  source_conf     = File.dirname(__FILE__) + '/../ultrasphinx/production_debian.conf'
  production_conf = File.dirname(__FILE__) + '/../ultrasphinx/production.conf'
  FileUtils.cp source_conf, production_conf
end
