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

Saa /^skal det ligge (\d+) læreplaner i basen$/ do |n|
  Laereplan.find(:all).length.should == n.to_i
end

Saa /^skal Kompetansemål eksistere i databasen$/ do
  kompetansemaal = Kompetansemaal.find :first
  kompetansemaal.should_not== nil
end

Saa /^Kompetansemål skal tilhøre Kompetansemålsett$/ do
  kompetansemaal = Kompetansemaal.find :first
  kompetansemaal.kompetansemaalsett.length.should >= 1
end

Saa /^skal det ligge minst (\d+) kompetansemålsett i basen$/ do |n|
  Kompetansemaalsett.find(:all).length.should >= n.to_i
end

Saa /^kompetansemålsettene skal tilhøre læreplaner$/ do
  Kompetansemaalsett.find(:first).laereplaner.length.should >= 1
end

