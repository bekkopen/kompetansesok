
Feature: Ropopulere nedtrekslister i søk vi læreplan
  For å finne et eller flere kompetansemål
  Må nedtrekslistene begrenses ut i fra valgt læreplan

  Scenario: Repopulere kompetansemålsett
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger laereplan_kode "ENG1-01"
    Så skal kompetansemaalsett repopuleres og inneholde følgende 5 elementer: 
      | tittel                                                                                    |
      | Etter 2. årstrinn                                                                         |
      | Etter 4. årstrinn                                                                         |
      | Etter 7. årstrinn                                                                         |
      | Etter 10. årstrinn                                                                        |
      | Etter Vg1 - studieforberedende utdanningsprogram og Vg2 - yrkesfaglige utdanningsprogram  |

