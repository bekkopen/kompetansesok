require File.dirname(__FILE__) + '/../support/env'

# Import til Fil

Gitt /^at feed er tilgjengelig på Internett$/ do
  @importerer = Kompetansesok::Importerer.new(Rails.root + '/tmp/import')
end

Naar /^jeg importerer (\d+) filer fra feeden til fil$/ do |n|
  @importerer.importer_til_fil(n.to_i)
end

Saa /^skal det ligge (\d+) RDF filer på disk$/ do |n|
  @importerer.filer.length.should == n.to_i
end

# Import til DB

Gitt /^at RDF\-filer er hentet til fil$/ do
  @importerer = Kompetansesok::Importerer.new(Rails.root + '/features/rdf')
end

Naar /^(\d+) RDF\-filer lastes inn i databasen$/ do |n|
  @importerer.importer_til_db(n.to_i)
end

Saa /^skal det ligge (\d+) (.*) i basen$/ do |n, klasse|
  klass = klasse.singularize.constantize
  klass.count.should == n.to_i
end

Saa /^(.*) skal ha relasjon til (.*)/ do |klasse, relasjonsklasse|
  klass = klasse.singularize.constantize
  relasjon = relasjonsklasse.pluralize.downcase.to_sym
  instans = klass.find :first
  instans.send(relasjon).should_not be_nil
end