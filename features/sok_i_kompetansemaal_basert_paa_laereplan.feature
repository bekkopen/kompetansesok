# http://www.pivotaltracker.com/story/show/308162
Feature: Skal kunne søke i kompetansemål basert på læreplan
  For å finne et eller flere kompetansemål
  Må jeg kunne se alle kompetansemålene som tilhører en eller flere læreplanen

  Scenario: Søke etter kompetansemål via læreplantittel
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn laereplan_tittel "Læreplan i musikk, samisk plan"
    Og jeg klikker søk
    Så skal jeg se 56 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                       |
      | utforske ulike musikalske uttrykk gjennom å improvisere med lyd og bevegelse |
      | delta i framføring med sang, samspill og bevegelse                           |
      | samtale om et musikkstykkes klang, melodi, rytme, dynamikk og tempo          |
      | gjenkjenne lyden av og kunne navn på noen instrumenter                       |


  Scenario: Søke etter kompetansemål via læreplankode
    Gitt at jeg er på læreplan søkesiden
    Når jeg fyller inn laereplan_kode "NOK2-01"
    Og jeg klikker søk
    Så skal jeg se 39 kompetansemål
    Og jeg skal se følgende spesifikke kompetansemål:
      | tittel                                                                                                          |
      | gjøre rede for regnskapslovens krav til miljørapportering                                                       |
      | vurdere lønnsomhet, likviditet og finansiering                                                                  |
      | gjøre rede for hva innovasjon og entreprenørskap betyr for verdiskaping og sysselsetting i dagens samfunn       |
      | gjøre rede for hvordan bedrifter kan øke endringsberedskapen gjennom kompetanseutvikling og organisasjonslæring |