# http://www.pivotaltracker.com/story/show/308162
Feature: Skal kunne søke i kompetansemål basert på læreplan
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører en eller flere læreplanen

  Scenario: Søke etter læreplan og vise flere kompetansemål
    Gitt at jeg er på læreplan søkesiden
    Når jeg søker etter "Læreplan i musikk, samisk plan"
    Så skal jeg se 10 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | beskrive hvordan den samiske musikken og dens historie er knyttet til samisk fortellertradisjon, historie, mytologi og kristendom |
      | gjenkjenne og benevne forskjellige instrumenter og ensembler innenfor ulike sjangere |
      | gjøre rede for regler for opphavsrett knyttet til bruk av musikk |


   Scenario: Ved å søke på skal jeg kunne paginere
    Gitt at jeg er på læreplan søkesiden
    Når jeg søker etter "fordypning i samisk"
    Så skal jeg se 10 kompetansemål



   Scenario: Navigere i søkeresultat
    GittScenario: Ved å søke på skal jeg kunne paginere
    Når jeg trykker på side 2
    Så skal jeg se 6 kompetansemål