# http://www.pivotaltracker.com/story/show/299149
Feature: Skal kunne liste alle kompetansemål i en læreplan
  For å få oversikt over en læreplan
  Må jeg kunne se alle kompetansemålene som tilhører læreplanen

  Scenario: Vise kompetansemål
    Gitt at 2 RDF-filer er lastet i databasen
    Og at jeg viser læreplaner
    Når jeg velger en læreplan
    Så skal jeg se de tilhørende kompetansemålene
    