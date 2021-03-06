
Gitt /^at språket er Bokmål$/ do
  # er bokmål som default
end

Når /^jeg velger (\w+) som språk$/ do |spraak|
  select spraak, :from => "spraak_valg"
  click_button "Bytt språk"
end

Så /^skal jeg se hovedsiden på engelsk$/ do
  response.body.should =~ /Search/
  response.body.should_not =~ /Søk/
end
