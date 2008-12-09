# http://www.pivotaltracker.com/story/show/299284
Feature: Importere kompetansemålsett fra RDF til database
  For å kunne søke etter kompetansemål
  Må en regelmessig jobb kunne importere kompetansemålsett RDF fra fil til database

  # @K1 @K3 @K4 @K55.1
  Scenario: Parse kompetansemaalsett
    Gitt at RDF-filer er hentet til fil
    Når 2 RDF-filer lastes inn i databasen
    Så skal det ligge 4 Kompetansemaalsett i basen
    Og Kompetansemaalsett skal tilhøre Laereplan
    Og Kompetansemaalsett skal tilhøre Trinn
