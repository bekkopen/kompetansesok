
Saa /^skal jeg kunne se .* "(.+)"$/ do |tittel|
  response.should contain(tittel)
end

Saa /^jeg skal kunne se disse kompetansemaal.*:$/ do |kompetansemaal|
  kompetansemaal.hashes.each do |rad|
    response.should contain(encode(rad['Tittel']))
  end
end

Saa /^jeg skal kunne gå til disse (\w+):$/ do |type, rader|
  rader.hashes.each do |rad|
    response.should have_tag('a', rad['Tittel'])
  end
end
