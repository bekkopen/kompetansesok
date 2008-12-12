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


  Scenario: Søke på kompetansemål basert på læreplantittel og trinn
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger laereplan_tittel "dans"
    Og jeg velger trinn "Videregående trinn 2"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål
    Og jeg skal få 3 sider med resultater
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                      |
      | forklare grunnleggende prinsipper for trening og ergonomi                                   |
      | beskrive kroppens oppbygning og funksjon relatert til dans og anvende dette i dansetrening  |


  Scenario: Søke på kompetansemål basert på læreplantittel og kompetansemåltittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger laereplan_tittel "kristendom"
    Og jeg velger kompetansemaal_tittel "samisk"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                              |
      |  diskutere helbredelse og tyding av tegn i samisk tradisjon                         |
      |  samtale om kjente hellige steder i naturen og deres betydning i samisk tradisjon   |
