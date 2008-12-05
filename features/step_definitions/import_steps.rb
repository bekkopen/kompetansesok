require File.dirname(__FILE__) + '/../support/env'

Gitt /^at feed er tilgjengelig på Internett$/ do
  @importer = Kompetansesok::Importerer.new(Rails.root + '/tmp/import')
end

Gitt /^at det ikke ligger noen gamle importerte filer på disk$/ do
  @importer.slett_filer
end

Gitt /^at RDF filer er hentet til disk$/ do
end

Naar /^jeg importerer (\d+) filer$/ do |n|
  @importer.importer_til_fil(n.to_i)
end

Naar /^jeg parser (\d+) RDF filer$/ do |n|
  @importer = Kompetansesok::Importerer.new(Rails.root + '/features/rdf')
  @importer.importer_til_db(n.to_i)
end

Saa /^skal det ligge (\d+) RDF filer på disk$/ do |n|
  @importer.filer.length.should == n.to_i
end

Saa /^skal det ligge minst (\d+) (.*) i basen$/ do |n, klasse|
  klass = klasse.singularize.constantize
  klass.count.should >= n.to_i
end

Saa /^(.*) skal tilhøre (.*)/ do |klasse, relasjonsklasse|
  klass = klasse.singularize.constantize
  relasjon = relasjonsklasse.singularize.downcase.to_sym
  instans = klass.find :first
  instans.send(relasjon).should_not be_nil
end