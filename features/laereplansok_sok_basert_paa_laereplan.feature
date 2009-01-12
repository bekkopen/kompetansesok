# http://www.pivotaltracker.com/story/show/308162
Feature: Skal kunne søke i kompetansemål basert på læreplan
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører en eller flere læreplanen

  Scenario: Søke etter kompetansemål via læreplantittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn Læreplantittel "Læreplan i musikk, samisk plan"
    Og jeg klikker søk
    Så skal jeg se 56 kompetansemål totalt
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | beskrive hvordan den samiske musikken og dens historie er knyttet til samisk fortellertradisjon, historie, mytologi og kristendom |
      | bruke relevante faglige begreper i presentasjon |


   Scenario: Ved å søke på skal jeg kunne paginere
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn Læreplantittel "fordypning i samisk"
    Og jeg klikker søk
    Så skal jeg se 16 kompetansemål totalt

   Scenario: Navigere i søkeresultat
    GittScenario: Ved å søke på skal jeg kunne paginere
    Når jeg trykker på side 2
    Så skal jeg se 16 kompetansemål totalt


  Scenario: Søke etter kompetansemål via læreplankode
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn Læreplankode "NOK2-01"
    Og jeg klikker søk
    Så skal jeg se 39 kompetansemål totalt
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                                                  |
      | beregne finansieringskostnader, utarbeide forslag til finansiering av ulike prosjekter og begrunne valg av alternativer |

  Scenario: Søke etter kompetansemål via læreplankode og læreplantittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn Læreplankode "IDR"
    Og jeg fyller inn Læreplantittel "friluftsliv"
    Og jeg klikker søk
    Så skal jeg se 22 kompetansemål totalt
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                      |
      | behandle og vedlikeholde redskap og utstyr slik at det til enhver tid er i orden            |


