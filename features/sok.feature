Egenskap: Søk
  For å kunne markere læremidler
  Må lærere, bibliotekarer og forleggere
  kunne søke etter kompetansemål
  
  Scenario: Tomt søk
    Gitt at jeg står på hovedsiden
    Når jeg søker etter ""
    Så skal jeg ikke få noen treff
    Og jeg skal se "Vennligst angi et søkekriterium"
  
  Scenario: Få 9 treff på "samisk kultur"
    Gitt at jeg står på hovedsiden
    Når jeg søker etter "'samisk kultur'"
    # Sjekk manuelt at de kommer alfabetisk
    Så skal jeg få opp følgende treff:
      | Tittel starter med                           |
      | beskrive særtrekk ved bygninger              |
      | diskutere hovedtrekk og variasjoner i samisk |
      | fortelle om sentrale trekk ved samisk        |
      | gjere greie for visuelle uttrykk og          |
      | gjøre rede for visuelle uttrykk og           |
      | observere og beskrive årstidene, døgn        |
      | presentere hovudtrekk ved samisk kultur      |
      | sammenligne levesett og omgangsformer        |
      | samtale om utviklingen av samisk kultur      |
    Og jeg skal ikke se "Vennligst angi et søkekriterium"

  Scenario: Få 1 treff på "gjeldende prosedyrer og regelverk"
    Gitt at jeg står på hovedsiden
    Når jeg søker etter "gjeldende prosedyrer og regelverk"
    Så skal jeg få opp følgende treff:
      | Tittel starter med                           |
      | utføre arbeid i tråd med gjeldende prosedyrer|
