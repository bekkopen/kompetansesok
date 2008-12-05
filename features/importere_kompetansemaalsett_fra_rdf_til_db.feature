# http://www.pivotaltracker.com/story/show/299284
Feature: Importere kompetansemålsett fra RDF til database
  For å kunne søke etter kompetansemål
  Må en regelmessig jobb kunne importere kompetansemålsett RDF fra fil til database

  # @K1 @K3 @K4 @K55.1
  Scenario: Parse kompetansemaalsett
    Gitt at RDF filer er hentet til disk
    Når jeg parser 2 RDF filer
    Så skal det ligge minst 2 Kompetansemaalsett i basen
    Og Kompetansemaalsett skal tilhøre Laereplan
