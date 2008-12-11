# http://www.pivotaltracker.com/story/show/308162
Feature: Skal kunne søke i kompetansemål basert på læreplan
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører en eller flere læreplanen

  Scenario: Søke etter læreplan og vise flere kompetansemål
    Gitt at jeg er på læreplan søkesiden
    Når jeg søker etter "Læreplan i musikk, samisk plan"
    Så skal jeg se 56 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | utforske ulike musikalske uttrykk gjennom å improvisere med lyd og bevegelse |
      | delta i framføring med sang, samspill og bevegelse                           |
      | samtale om et musikkstykkes klang, melodi, rytme, dynamikk og tempo          |
      | gjenkjenne lyden av og kunne navn på noen instrumenter                       |
