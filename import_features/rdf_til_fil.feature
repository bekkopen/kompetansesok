# http://www.pivotaltracker.com/story/show/295512
Feature: Hente RDF fra Internett til fil
  For å kunne søke
  Må en regelmessig jobb kunne importere RDF til fil

  # @K1 @K3 @K4 @K55.1
  Scenario: Hente ned et utvalg RDF fra Atom feed
    Gitt at feed er tilgjengelig på Internett
    Når jeg importerer 3 filer fra feeden til fil
    Så skal det ligge 3 RDF filer på disk
