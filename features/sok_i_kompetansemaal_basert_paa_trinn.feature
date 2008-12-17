
Feature: Skal kunne søke i kompetansemål basert på trinn
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører et trinn

  Scenario: Søke på kompetansemål basert på trinn
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger trinn "ET_TRINN"
    Og jeg klikker søk
    Så skal jeg se 10 kompetansemål totalt
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                     |
      | bruke ball i leikar og nokre ballspel                                                      |
      |bruke ski og skøyter der det ligg til rette for det                                         |
