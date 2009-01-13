Feature: Bytte språk
  For å støtte brukere med forskjellig språk
  Må en bruker kunne bytte språk

  Scenario: Bytte fra bokmål til nynorsk
    Gitt at jeg er på hovedsiden
    Og at språket er Bokmål
    Når jeg velger Nynorsk som språk
    Så skal jeg se hovedsiden på nynorsk

  Scenario: Gå til hovedside
    Gitt at jeg er på læreplan søkesiden
    Når jeg velger Nynorsk som språk
    Så skal jeg bli tatt til hovedsiden

