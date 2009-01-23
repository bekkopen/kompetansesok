if Rails.env == 'production' && defined?(JRUBY_VERSION) && !ENV['SKIP_SETUP_DATA'] 
  # Vi er på Glassfish i Prod.
  # TODO: Legg ut path i egen config og bruk fra script som deployer.
  Ultrasphinx::CONF_PATH.replace('/usr/local/etc/sphinx.conf')
end
