# http://www.pivotaltracker.com/story/show/295480
Feature: Importere kompetansemaal fra RDF til database
  For å kunne søke
  Må en regelmessig jobb kunne importere RDF fra fil til database
  
  # @K1 @K3 @K4 @K55.1
  Scenario: Parse RDF filer
    Gitt at RDF filer er hentet til disk
    Når jeg parser 2 RDF filer
    Så skal det ligge 3 læreplaner i basen
