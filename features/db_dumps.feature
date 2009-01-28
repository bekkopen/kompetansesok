Feature: Laste ned database
  For å kunne eksportere data effektict
  Må en bruker kunne laste ned mysql db_dumps fra siten

  Scenario: Liste over filer
    Gitt at følgende databasefiler finnes:
      | navn       |
      | lørdag.zip |
      | fredag.zip |
    Og at jeg er på hovedsiden
    Når jeg klikker på linken "Database eksport"
    Så skal jeg se følgende liste over databasefiler
      | navn       |
      | lørdag.zip |
      | fredag.zip |

  Scenario: Tom liste når ingen dumps er laget
    Gitt at ingen databasefiler finnes
    Og at jeg er på hovedsiden
    Når jeg klikker på linken "Database eksport"
    Så skal jeg ikke se noen databasefiler
