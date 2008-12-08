# http://www.pivotaltracker.com/story/show/299284
Feature: Importere kompetansemålsett fra RDF til database
  For å kunne søke etter kompetansemål
  Må en regelmessig jobb kunne importere kompetansemålsett RDF fra fil til database

  # @K1 @K3 @K4 @K55.1
  Scenario: Parse kompetansemaalsett
    Gitt at 2 RDF-filer er lastet i databasen
    Så skal det ligge 3 Kompetansemaalsett i basen
    Og Kompetansemaalsett skal tilhøre Laereplan
