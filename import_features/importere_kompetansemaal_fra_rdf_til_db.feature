# http://www.pivotaltracker.com/story/show/295480
Feature: Importere kompetansemål fra RDF til database
  For å kunne søke frem kompetansemaal
  Må en regelmessig jobb kunne importere kompetansemål RDF fra fil til database

  Scenario: Parse kompetansemål fra RDF
    Gitt at RDF-filer er hentet til fil
    Når 1 RDF-filer lastes inn i databasen
    Så skal det ligge 38 Kompetansemaal i basen
    Og Kompetansemaal skal tilhøre Kompetansemaalsett
    Og Kompetansemaal skal tilhøre Hovedomraade


