# To change this template, choose Tools | Templates
# and open the template in the editor.


require "rexml/document"


puts "Lager en kombinert RDF fil"

%x[rm all.rdf.test]
%x[echo "<root>" >> all.rdf.test]
%x[cat features/rdf/*rdf >> all.rdf.test]
%x[echo "</root>" >> all.rdf.test]



puts "Parser all.rdf.test.."
file = File.new( "all.rdf.test" )
doc = REXML::Document.new file


puts "Sjekker for referanser til mer en et kompetansemålsett i kompetansemål"
REXML::XPath.each(doc, "//rdf:type[@rdf:resource='http://psi.udir.no/ontologi/kompetansemaal']") do |e|
  i = 0
  e.parent.elements.each("grep:kompetansemaalsett_har_kompetansemaal") do |c|
    i += 1
  end
  puts "\n FLERE ENN ET KOMPETANSEMAALSETT #{e.parent.inspect} \n " if i > 1

end

puts "\nSjekker for referanser til mer enn en læreplan i kompetansemålsett"

REXML::XPath.each(doc, "//rdf:type[@rdf:resource='http://psi.udir.no/ontologi/kompetansemaalsett']") do |e|
  i = 0
  e.parent.elements.each("grep:kompetansemaalsett_etter_laereplan") do |c|
    i += 1
  end
  puts "\n FLERE ENN EN LAEREPLAN #{e.parent.inspect} \n " if i > 1

end

puts ""

