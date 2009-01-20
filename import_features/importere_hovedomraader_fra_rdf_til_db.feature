# http://www.pivotaltracker.com/story/show/299280
Feature: Importere hovedområder fra RDF til databasee
  For å kunne søke etter kompetansemål
  Må en regelmessig jobb kunne importere hovedområder RDF fra fil til database

  Scenario: Parse hovedomraader
    Gitt at RDF-filer er hentet til fil
    Når 2 RDF-filer lastes inn i databasen
    Så skal det ligge 5 Hovedomraade i basen
    Og Hovedomraade skal ha relasjon til Kompetansemaal
    Og Hovedomraade skal ha relasjon til Laereplan
