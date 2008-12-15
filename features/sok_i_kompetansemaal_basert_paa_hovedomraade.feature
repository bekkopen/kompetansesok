# http://www.pivotaltracker.com/story/show/298555

Feature: Skal kunne søke i kompetansemål basert på hovedområde
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører et hovedområde

  Scenario: Søke på kompetansemål basert på hovedområde
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger hovedomraade "Administrasjon, salg og økonomi"
    Og jeg klikker søk
    Så skal jeg se 8 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | gjøre rede for arbeidsoppgaver, rutiner, markedsføring og organisering       |
      | behandle klager og reklamasjoner                                             |


