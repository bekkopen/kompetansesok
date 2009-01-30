require File.dirname(__FILE__) + '/../support/env'

# Import til Fil

Gitt /^at feed er tilgjengelig på Internett$/ do
  @importerer = Kompetansesok::Importerer.new(Rails.root + '/tmp/import')
end

Når /^jeg importerer (\d+) filer fra feeden til fil$/ do |n|
  @importerer.importer_til_fil(n.to_i)
end

Så /^skal det ligge (\d+) RDF filer på disk$/ do |n|
  @importerer.filer.length.should == n.to_i
end

# Import til DB

Gitt /^at RDF\-filer er hentet til fil$/ do
  @importerer = Kompetansesok::Importerer.new(Rails.root + '/features/rdf')
end

Når /^(\d+) RDF\-filer lastes inn i databasen$/ do |n|
  @importerer.importer_til_db(n.to_i)
end

Så /^skal det ligge (\d+) (.*) i basen$/ do |n, klasse|
  klass = klasse.singularize.constantize
  klass.count.should == n.to_i
end

Så /^(.*) skal ha relasjon til (.*)/ do |klasse, relasjonsklasse|
  klass = klasse.singularize.constantize
  relasjon = relasjonsklasse.pluralize.downcase.to_sym
  instans = klass.find :first
  instans.send(relasjon).first.should_not be_nil
end


Når /^jeg leser inn alle rdfene$/ do
  @importerer.les_filer(nil)
end

Så /^skal jeg kunne se en unik nøkkel "(.+)"$/ do |md5sum|
  @importerer.md5sum_av_leste_filer.should == md5sum
end

Så /^lagrer jeg summen$/ do
  RdfMd5Sum.current = @importerer.md5sum_av_leste_filer.to_s
end

Så /^skal det ikke være behov for oppdateringer$/ do
  @importerer.new_rdf_data?.should be_false
end