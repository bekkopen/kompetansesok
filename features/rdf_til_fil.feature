# http://www.pivotaltracker.com/story/show/295512
Feature: Hente RDF fra Internett til fil
  For å kunne søke
  Må en regelmessig jobb kunne importere RDF til fil

  # @K1 @K3 @K4 @K55.1
  Scenario: Hente ned all RDF fra Atom feed
    Gitt at feed er tilgjengelig på Internett
    Og at det ikke ligger noen gamle importerte filer på disk
    Når jeg importerer 3 filer
    Så skal det ligge 3 RDF filer på disk
