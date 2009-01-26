Feature: Laste ned database
  For å kunne eksportere data effektict
  Må en bruker kunne laste ned mysql db_dumps fra siten

  Scenario: Liste over filer
    Gitt at følgende databasefiler finnes:
      | navn       |
      | fredag.zip |
      | lørdag.zip |
    Og at jeg er på hovedsiden
    Når jeg klikker på linken "Last ned databasen"
    Så skal jeg se følgende liste over databasefiler
      | navn       |
      | fredag.zip |
      | lørdag.zip |

  Scenario: Tom liste når ingen dumps er laget
    Gitt at ingen databasefiler finnes
    Og at jeg er på hovedsiden
    Når jeg klikker på linken "Last ned databasen"
    Så skal jeg ikke se noen databasefiler
