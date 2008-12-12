Feature: Skal kunne søke i kompetansemål basert må kombinasjon av input
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene for et kombinert søk

  Scenario: Søke på kompetansemål basert på hovedområde og kompetansemålsett
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger kompetansemaalsett "Bevegelse"
    Og jeg velger hovedomraade "Grunntrening"
    Og jeg klikker søk
    Så skal jeg se 4 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                    |
      | anvende grunnleggende oppvarmings-, avspennings- og konsentrasjonsøvinger |
      | vise og forklare sammenhenger mellom kropp og bevegelseskvaliteter        |


