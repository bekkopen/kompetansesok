# http://www.pivotaltracker.com/story/show/295480
Feature: Importere kompetansemål fra RDF til database
  For å kunne søke frem kompetansemaal
  Må en regelmessig jobb kunne importere kompetansemål RDF fra fil til database

  Scenario: Parse kompetansemål fra RDF
    Gitt at RDF filer er hentet til disk
    Når jeg parser 1 RDF filer
    Så skal det ligge 38 Kompetansemaal i basen
    Og Kompetansemål skal tilhøre Kompetansemålsett


