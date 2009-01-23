Egenskap: Vise kompetansemaalsett for en læreplan
  For å lettere få oversikt over sammenhengen
  Må lærere, bibliotekarer og forleggere
  Kunne se kompetansemålene som hører til et kompetansemaalsett filtrert på læreplan

  Scenario: Gå til kompetansemålsett
    Gitt at jeg ser på laereplan med uuid uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd
    Når jeg velger kompetansemaalsett "Etter 10. årstrinn"

  Scenario: Vise kompetansemål
    GittScenario: Gå til kompetansemålsett
    Så skal jeg få kompetansemaalsett "uuid:3db15da8-7acc-464d-a5d0-0b855d36bb96" nøstet under laereplan "uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd"
    Og skal jeg få opp følgende treff i kompetansemål:
      | Tittel starter med                                                                                                      |
      | utvikle og presentere sammensatte tekster med utgangspunkt i forfatterskap ved hjelp av digitale verktøy                |
      | framføre et program sammensatt av ulike uttrykksformer basert på egne eller andres tekster                              |
      | formidle og kommentere medieoppslag fra selvvalgte medier og lage egne oppslag for ulike medier                         |
      | formidle egne opplevelser av film, teater og musikk og vurdere bruk av virkemidler                                      |
      | gjøre rede for språklige virkemidler i moderne kommunikasjonsformer og bruke disse i egen tekstproduksjon               |
      | utforske og vurdere hvordan digitale medier påvirker og endrer språk og kommunikasjon                                   |
      | dokumentere og vurdere egen utvikling i arbeid med utforskning av språk og tekst                                        |
      | sammenlikne og vurdere nettsider med hensyn til bruksmåter, informasjonsverdi og design                                 |
      | sammenlikne og vurdere kritisk ulike norskspråklige kilder i forhold til innhold, opphavsrett og personvern             |
      | lese og presentere et utvalg selvvalgt skjønnlitteratur og sakprosa                                                     |
      | produsere skriftlig og presentere muntlig selvvalgte fordypningsarbeider                                                |
      | planlegge, gjennomføre og presentere en undersøkelse av hvordan barn og unge bruker språk i eget nærmiljø og hvordan    |
      | presentere ordspråk og billedlige uttrykk på norsk og sammenlikne med andre språk, og samtale om hvordan slike uttrykk  |
      | eksperimentere med ulike skriftlige og muntlige uttrykksformer i ulike sjangere                                         |
      | oversette enkle tekster fra engelsk eller andre språk til norsk og forklare hvordan mening endres i forhold til ordvalg |
      | sammenlikne ord og grammatiske former i skriftlig norsk med norsk talemål og presentere resultatet av sammenlikningen   |
      | dokumentere og vurdere egen utvikling i arbeid med tekster                                                              |

  Scenario: Vise brødsmulesti
    GittScenario: Gå til kompetansemålsett
    Så jeg skal se Læreplan "Læreplan i fordypning i norsk" i brødsmulestien
    Så jeg skal se Kompetansemaalsett "Etter 10. årstrinn" i brødsmulestien