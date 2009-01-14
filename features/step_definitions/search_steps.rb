
Naar /^jeg fyller inn (\w+) "(.*)"$/ do |felt, sok|
  fill_in felt, :with => sok.to_s  
end

Naar /^jeg velger (\w+) "([^\"]*)"$/ do |felt, hovedomraade|
  select hovedomraade, :from => felt
end


Naar /^jeg trykker på side (\d+)$/ do |n|
  click_link n.to_s
end


Saa /^skal jeg se (\d+) kompetansemål totalt$/ do |n|
  response.should have_tag('div#antall_treff', n)
end

Saa /^jeg skal få (\d+) sider med resultater$/ do |n|
  response.should have_tag('a', n)
end

Saa /^jeg skal se følgende spesifikke kompetansemål:$/ do |tabell|
  tabell.hashes.each do |kompetansemaal|
    response.should contain(encode(kompetansemaal['tittel']))
  end
end

Saa /^skal (\w+) repopuleres og inneholde følgende (\d+) elementer:$/ do |felt, antall, tabell|
  pending "hvordan får vi testet dette?"

  tabell.hashes.each do |option|

  end
end


