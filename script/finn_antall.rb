sokeord = ARGV.join(" ")

if sokeord.blank?
  puts "du må spesifisere et søkeord.\nEksempel: finn_antall.rb samisk"
else
  puts "\n\n*****\n\n"
  puts "Søker etter: #{sokeord}"
  puts "\n"

  maal = Kompetansemaal.find(:all, :conditions => "tittel like '%#{sokeord}%'")
  hovedomraader = Hovedomraade.find(:all, :conditions => "tittel like '%#{sokeord}%'")
  maalsett = Kompetansemaalsett.find(:all, :conditions => "tittel like '%#{sokeord}%'")
  laereplaner = Laereplan.find(:all, :conditions => "tittel like '%#{sokeord}%'")
  
  puts "Antall kompetansemål: #{maal.length}"
  puts "Antall hovedområder: #{hovedomraader.length}"
  puts "Antall kompetansemålsett: #{maalsett.length}"
  puts "Antall læreplaner: #{laereplaner.length}"
  puts puts "\n\n*****\n\n"
end

