Feature: Bytte språk
  For å støtte brukere med forskjellig språk
  Må en bruker kunne bytte språk

  Scenario: Bytte fra bokmål til engelsk
    Gitt at jeg er på hovedsiden
    Og at språket er Bokmål
    Når jeg velger Engelsk som språk
    Så skal jeg se hovedsiden på engelsk

  Scenario: Gå til hovedside
    Gitt at jeg er på infosiden
    Når jeg velger Engelsk som språk
    Så skal jeg bli tatt til hovedsiden

