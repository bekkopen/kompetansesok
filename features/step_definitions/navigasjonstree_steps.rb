
Saa /^skal jeg kunne se hovedomraade "(.+)"$/ do |tittel|
  response.should contain(tittel)
end

Saa /^jeg skal kunne se disse kompetansemaalene:$/ do |kompetansemaal|
  kompetansemaal.hashes.each do |rad|
    response.should contain(encode(rad['Tittel']))
  end
end
