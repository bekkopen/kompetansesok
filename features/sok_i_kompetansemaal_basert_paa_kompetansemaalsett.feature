# http://www.pivotaltracker.com/story/show/299285

Feature: Skal kunne søke i kompetansemål basert på kompetansemålsett
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører et kompetansemålsett

  Scenario: Søke på kompetansemål basert på kompetansemålsett
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger kompetansemaalsett "Bevegelse"
    Og jeg klikker søk
    Så skal jeg se 8 kompetansemål totalt
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                            |
      | anvende ulike inspirasjonskilder som grunnlag for utfoldelse og fysiske uttrykk   |
      | samhandle om planlegging og gjennomføring av relevant trening og bevegelse        |


