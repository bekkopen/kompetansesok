Egenskap: Vise hovedområde for en læreplan
  For å lettere få oversikt over sammenhengen
  Må lærere, bibliotekarer og forleggere
  kunne visuelt se kompetansemaalene til et hovedområde filtrert på læreplan

  Scenario: Vise kompetansemål
    Gitt at jeg ser på laereplan med uuid uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd
    Og jeg velger hovedomraade "Utforsking av språk og tekst"
    Og at jeg ser på laereplan med uuid uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd
    Når jeg velger hovedomraade "Utforsking av språk og tekst"
    Så skal jeg få hovedomraade "uuid:9f87b126-7f07-44da-bfec-3bdffd779df2" nøstet under laereplan "uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd"
    Og skal jeg få opp følgende treff i kompetansemål:
      | Tittel starter med                                                                            |
      | dokumentere og vurdere egen utvikling i arbeid med utforskning av språk og tekst              |
      | utforske og vurdere hvordan digitale medier påvirker og endrer språk og kommunikasjon         |
      | oversette enkle tekster fra engelsk eller andre språk til norsk og forklare hvordan mening    |
      | gjøre rede for språklige virkemidler i moderne kommunikasjonsformer og bruke disse i egen     |
      | planlegge, gjennomføre og presentere en undersøkelse av hvordan barn og unge bruker språk     |
      | eksperimentere med ulike skriftlige og muntlige uttrykksformer i ulike sjangere               |
      | sammenlikne ord og grammatiske former i skriftlig norsk med norsk talemål og presentere       |
      | presentere ordspråk og billedlige uttrykk på norsk og sammenlikne med andre språk, og samtale |
    Så skal jeg se "Læreplan i fordypning i norsk" på plass "1" i brødsmulestien
    Og jeg skal se "Utforsking av språk og tekst" på plass "2" i brødsmulestien

  Scenario: Klikbar brødsmulesti fra hovedområdet til læreplan
    Gitt at jeg ser på laereplan med uuid uuid:90893023-ff29-45dd-86d3-1c26bad9e3bd
    Og jeg velger hovedomraade "Utforsking av språk og tekst"
    Når jeg klikker på linken "Læreplan i fordypning i norsk"
    Så skal jeg se "Læreplan i fordypning i norsk" på plass "1" i brødsmulestien