# http://www.pivotaltracker.com/story/show/299270
Feature: Importere læreplaner fra RDF til databasese
  For å kunne søke basert på læreplaner
  Må en regelmessig jobb kunne importere læreplaner RDF fra fil til database
  
  # @K1 @K3 @K4 @K55.1
  Scenario: Parse læreplaner
    Gitt at RDF filer er hentet til disk
    Når jeg parser 2 RDF filer
    Så skal det ligge 2 læreplaner i basen
