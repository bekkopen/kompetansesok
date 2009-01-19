
Saa /^skal jeg kunne se .* "(.+)"$/ do |tittel|
  response.should contain(tittel)
end

Saa /^jeg skal kunne se disse kompetansemaal.*:$/ do |kompetansemaal|
  kompetansemaal.hashes.each do |rad|
    response.should contain(encode(rad['Tittel']))
  end
end

Saa /^jeg skal kunne gå til disse kompetansemaalsettene:$/ do |rad|
  rad.hashes.each do |rad|
    #TODO sjekke etter link istede for teksten
    response.should contain(rad['tittel'])
    #response.should contain(encode(rad['uuid']))
  end
end
