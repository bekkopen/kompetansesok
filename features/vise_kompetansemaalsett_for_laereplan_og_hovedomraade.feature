Egenskap: Vise kompetansemaalsett for en læreplan og hovedområde
  For å lettere få oversikt over sammenhengen
  Må lærere, bibliotekarer og forleggere
  Kunne se kompetansemålene som hører til et kompetansemaalsett filtrert på læreplan og hovedområde

  Scenario: Vise kompetansemål
    Gitt at jeg har gått til LP uuid:9089 / H språk og tekst / KS etter 10. årstrinn
    Og skal jeg få opp følgende treff i kompetansemål:
      | Tittel starter med                                                                    |
      | gjøre rede for språklige virkemidler i moderne kommunikasjonsformer og                |
      | utforske og vurdere hvordan digitale medier påvirker og endrer språk og kommunikasjon |
      | dokumentere og vurdere egen utvikling i arbeid med utforskning av språk og tekst      |
      | planlegge, gjennomføre og presentere en undersøkelse av hvordan barn og unge bruker   |
      | presentere ordspråk og billedlige uttrykk på norsk og sammenlikne med andre språk     |
      | eksperimentere med ulike skriftlige og muntlige uttrykksformer i ulike sjangere       |
      | oversette enkle tekster fra engelsk eller andre språk til norsk og forklare hvordan   |
      | sammenlikne ord og grammatiske former i skriftlig norsk med norsk talemål og          |

  Scenario: Vise nøstede kompetansemålsett
    Gitt at jeg har gått til LP uuid:9089 / H språk og tekst / KS etter 10. årstrinn
    Så skal jeg få kompetansemaalsett "uuid:3db15da8-7acc-464d-a5d0-0b855d36bb96" nøstet under laereplan "uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd"
    Så skal jeg få kompetansemaalsett "uuid:3db15da8-7acc-464d-a5d0-0b855d36bb96" nøstet under hovedomraade "uuid:9f87b126-7f07-44da-bfec-3bdffd779df2"

  Scenario: Vise brødsmulesti
    Gitt at jeg har gått til LP uuid:9089 / H språk og tekst / KS etter 10. årstrinn
    Så skal jeg se "Læreplan i fordypning i norsk" på plass "1" i brødsmulestien
    Og skal jeg se "Utforsking av språk og tekst" på plass "2" i brødsmulestien
    Og skal jeg se "Etter 10. årstrinn" på plass "3" i brødsmulestien

  Scenario: Klikkbar brødsmulesti fra Kompetansemålsett til læreplan
    Gitt at jeg har gått til LP uuid:9089 / H språk og tekst / KS etter 10. årstrinn
    Når jeg klikker på linken "Læreplan i fordypning i norsk"
    Så skal jeg se "Læreplan i fordypning i norsk" på plass "1" i brødsmulestien

  Scenario: Klikkbar brødsmulesti fra Kompetansemålsett til hovedområde
    Gitt at jeg har gått til LP uuid:9089 / H språk og tekst / KS etter 10. årstrinn
    Når jeg klikker på linken "Utforsking av språk og tekst"
    Så skal jeg se "Utforsking av språk og tekst" på plass "1" i brødsmulestien
