
Gitt /^at språket er Bokmål$/ do
  # er bokmål som default
end

Naar /^jeg velger (\w+) som språk$/ do |spraak|
  select spraak, :from => "spraak_valg"
  click_button "Velg språk"
end

Saa /^skal jeg se hovedsiden på nynorsk$/ do
  response.body.should =~ /Infotekst for hovedside - nynorsk/
end

