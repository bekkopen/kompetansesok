# http://www.pivotaltracker.com/story/show/308162
Feature: Skal kunne søke i kompetansemål basert på læreplan
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører en eller flere læreplanen

  Scenario: Søke etter kompetansemål via læreplantittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn laereplan_tittel "Læreplan i musikk, samisk plan"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | beskrive hvordan den samiske musikken og dens historie er knyttet til samisk fortellertradisjon, historie, mytologi og kristendom |
      | gjenkjenne og benevne forskjellige instrumenter og ensembler innenfor ulike sjangere |
      | gjøre rede for regler for opphavsrett knyttet til bruk av musikk |


   Scenario: Ved å søke på skal jeg kunne paginere
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn laereplan_tittel "fordypning i samisk"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål

   Scenario: Navigere i søkeresultat
    GittScenario: Ved å søke på skal jeg kunne paginere
    Når jeg trykker på side 2
    Så skal jeg se 6 kompetansemål


  Scenario: Søke etter kompetansemål via læreplankode
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn laereplan_kode "NOK2-01"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                                                  |
      | beregne finansieringskostnader, utarbeide forslag til finansiering av ulike prosjekter og begrunne valg av alternativer |
      | gjøre rede for interessegrupper og drøfte hva som kan utløse interessekonflikter ved fastsettelse av bedrifters mål     |

  Scenario: Søke etter kompetansemål via læreplankode og læreplantittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn laereplan_kode "IDR"
    Og jeg fyller inn laereplan_tittel "friluftsliv"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                      |
      | behandle og vedlikeholde redskap og utstyr slik at det til enhver tid er i orden            |
      | vurdere betydningen av et godt kosthold ut fra praktiske og ernæringsmessige forhold        |


