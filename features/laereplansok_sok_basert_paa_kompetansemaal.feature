
Feature: Skal kunne søke i kompetansemål basert på kompetansemål
  For å finne et eller flere kompetansemål
  Må jeg kunne søke basert på kompetansemåltittel

  Scenario: Søke etter kompetansemål basert på tittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn kompetansemaal_tittel "etableringsprosess"
    Og jeg klikker søk
    Så skal jeg se 1 kompetansemål totalt
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | anbefale og begrunne hensiktsmessig selskapsform for ulike etableringsprosjekter, og planlegge den formelle etableringsprosessen for en småbedrift |
     

