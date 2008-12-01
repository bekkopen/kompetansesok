Feature: Importere data fra GREP
  For å kunne utføre søk
  Må data fra GREP importeres i kompetansesok basen
  
  Scenario: Hente ned all RDF fra Atom feed
    Gitt at feed er tilgjengelig på Internett
    Og at det ikke ligger noen gamle importerte filer på disk
    Når jeg importerer 3 filer
    Så skal det ligge 3 RDF filer på disk