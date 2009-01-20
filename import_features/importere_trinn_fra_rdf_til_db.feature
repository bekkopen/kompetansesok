# http://www.pivotaltracker.com/story/show/304413
Feature: Importere trinn fra RDF til databasee
  For å få info trinn et kompetansemål er for
  Må en regelmessig jobb kunne importere trinn RDF fra fil til database

  Scenario: Parse trinn
    Gitt at RDF-filer er hentet til fil
    Når 2 RDF-filer lastes inn i databasen
    Så skal det ligge 3 Trinn i basen
    Og Trinn skal ha relasjon til Kompetansemaalsett
