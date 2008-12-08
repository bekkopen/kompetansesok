# http://www.pivotaltracker.com/story/show/299149
Feature: Skal kunne liste alle kompetansemål i en læreplan
  For å få oversikt over en læreplan
  Må jeg kunne se alle kompetansemålene som tilhører læreplanen

  Scenario: Vise kompetansemål
    Gitt at jeg viser læreplaner
    Når jeg velger Læreplan "Læreplan i musikk, samisk plan"
    Så skal jeg se 56 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | utforske ulike musikalske uttrykk gjennom å improvisere med lyd og bevegelse |
      | delta i framføring med sang, samspill og bevegelse                           |
      | samtale om et musikkstykkes klang, melodi, rytme, dynamikk og tempo          |
      | gjenkjenne lyden av og kunne navn på noen instrumenter                       |
  