Egenskap: Bla i læreplan
  For å kunne finne fram til en vilkårlig læreplan
  Må lærere, bibliotekarer og forleggere
  Kunne bla i alle læreplaner og drille videre derfra

  Scenario: Vise alle læreplaner
    Gitt at jeg er på "Bla i læreplan" -siden
    Så skal jeg kunne se 362 læreplaner

  Scenario: Gå til læreplan og tilbake
    Gitt at jeg er på "Bla i læreplan" -siden
    Når jeg klikker på linken "Læreplan i bakerfaget Vg3 / opplæring i bedrift"
    Så skal jeg kunne se Læreplanen "Læreplan i bakerfaget Vg3 / opplæring i bedrift"
    Når jeg klikker "Tilbake"
    Så skal jeg kunne se 362 læreplaner

  Scenario: Initiel sortering på tittel
    Gitt at jeg er på "Bla i læreplan" -siden
    Så skal jeg se følgende læreplan øverst "Læreplan i aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"

  Scenario: Sortering på kode og tittel
    Gitt at jeg er på "Bla i læreplan" -siden
    Når jeg klikker på linken "Sorter på kode"
    Så skal jeg se følgende læreplan øverst "ADI2-01"
    Når jeg klikker på linken "Sorter på tittel"
    Så skal jeg se følgende læreplan øverst "Læreplan i aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"

