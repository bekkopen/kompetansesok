Egenskap: Vise kompetansemaalsett for et fag
  For å lettere få oversikt over sammenhengen
  Må lærere, bibliotekarer og forleggere
  Kunne se kompetansemålene som hører til et kompetansemaalsett filtrert på fag

  Scenario: Vise kompetansemål
    Gitt at jeg ser på fag med uuid uuid:bf2c65fc-13cf-4e6c-88db-229878c4822c
    Når jeg velger kompetansemaalsett "Etter Vg2 - studieforberedende utdanningsprogram"
    Så skal jeg få kompetansemaalsett "uuid:50dbe5aa-e2dc-4cbd-af47-2e59c8abe785" nøstet under fag "uuid:bf2c65fc-13cf-4e6c-88db-229878c4822c"
    Og skal jeg få opp følgende treff i kompetansemål:
      | Tittel starter med                                                                                                                |
      | bruke setningsanalyse og fagtermer i beskrivelse av språk                                                                         |
      | analysere og gjøre rede for kommunikasjonsmåter og kommunikasjonsstrategier  i samiske samfunn før og nå                          |
      | lese enkle tekster på de andre samiske språkene                                                                                   |
      | vurdere og gi tilbakemelding på egne og andres muntlige presentasjoner                                                            |
      | velge passende sjanger, virkemidler og språkbruk ved produksjon av tekst                                                          |
      | gjøre rede for samisk språkhistorie                                                                                               |
      | samtale om hovedperiodene i samisk litteraturhistorie og sammenligne med nordisk litteraturhistorie                               |
      | drøfte hvordan skole, samfunn og arbeidsliv kan støtte opp om tospråklighet                                                       |
      | analysere tekster i ulike sjangere for å kunne ta stilling til spørsmål tekstene tar opp og verdier de representerer              |
      | sammenligne samiske og andre urfolks tekster og vurdere tekstenes betydning for kultur- og identitetsutvikling                    |
      | bruke fagkunnskap fra egne programfag i foredrag og diskusjoner om skole, samfunn og arbeidsliv                                   |
      | gjøre rede for joiketradisjonen og joikens status, verdi og situasjon før og nå                                                   |
      | tolke saker som angår skolen fra norsk til samisk                                                                                 |
      | beskrive og vurdere egne lese-og skrivestrategier                                                                                 |
      | lese og analysere et representativt utvalg av litteratur og tekster,  skjønnlitteratur og sakprosa, knyttet til perioden før 1965 |
      | diskutere hvordan språkets status i samfunnet har påvirket samenes språkkunnskaper, tospråklighet og selvfølelse                  |
      | vurdere Samelovens språkregler og Sametingets opprettelse i forhold til språksituasjon og tospråklighet                           |
      | lese tekster skrevet i eldre ortografi og sammenligne med dagens ortografi                                                        |
      | sammenligne samisk og norsk sang- og salmetradisjon                                                                               |


  Scenario: Vise brødsmulesti
    Gitt at jeg ser på fag med uuid uuid:bf2c65fc-13cf-4e6c-88db-229878c4822c
    Når jeg velger kompetansemaalsett "Etter Vg2 - studieforberedende utdanningsprogram"
    Så skal jeg se "Samisk som førstespråk, samisk 1, Vg2 studieforberedende utdanningsprogram" på plass "1" i brødsmulestien
    Og jeg skal se "Etter Vg2 - studieforberedende utdanningsprogram" på plass "2" i brødsmulestien