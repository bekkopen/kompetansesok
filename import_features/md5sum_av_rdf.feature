Feature: Sjekke om det har kommet ny rdf
  For å kunne vite om rdf'en har oppdatert seg
  Må en sjekke innholdet i den nynedlastede rdfen

  Scenario: Sjekke nedlastet rdf
    Gitt at RDF-filer er hentet til fil
    Så skal jeg kunne se en unik nøkkel "fc3ae9530092ae09fff8ca94684510b6"

  Scenario: Verifiser at to like rdf sammlinger er like
    Gitt at RDF-filer er hentet til fil
    Så lagrer jeg summen
    Så skal det ikke være behov for oppdateringer

  Scenario: Lese inn rdfer kun hvis det er behov
    Gitt at RDF-filer er hentet til fil
    Så lagrer jeg summen
    Så skal det ikke gjøres import
