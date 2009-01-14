# http://www.pivotaltracker.com/story/show/304416
Feature: Importere fag fra RDF til databasese
  For å kunne søke basert på fag
  Må en regelmessig jobb kunne importere fag RDF fra fil til database
  
  Scenario: Parse fag
    Gitt at RDF-filer er hentet til fil
    Når 2 RDF-filer lastes inn i databasen
    Så skal det ligge 0 Fag i basen
