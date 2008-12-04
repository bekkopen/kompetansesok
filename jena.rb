require 'java'
Dir[File.dirname(__FILE__) + '/lib/ext/jena-2.5.6/*.jar'].each do |jar|
  require jar
end

model = com.hp.hpl.jena.rdf.model.ModelFactory.createDefaultModel

grep = 'http://psi.udir.no/ontologi/'
kompetansemaal_property = model.getProperty(grep, 'kompetansemaalsett_har_kompetansemaal')
rdf_type = model.getProperty(grep, 'kompetansemaalsett_har_kompetansemaal')
title_property          = com.hp.hpl.jena.vocabulary.DC_11.title

fm = com.hp.hpl.jena.util.FileManager.get.open(ARGV[0])
model.read(fm, "")

model.write(java.lang.System.out)