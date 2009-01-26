
Naar /^jeg søker etter "(.*)"$/ do |sok|
  fill_in 'Søk', :with => sok
  click_button 'Søk' 
end

Saa /^skal jeg få opp følgende treff i kompetansemål:$/ do |sokeresultater|
  sokeresultater.hashes.each do |rad|
    response.should contain(encode(rad['Tittel starter med']))
  end
end

Saa /^skal jeg få opp følgende treff for (\w+):$/ do |type, sokeresultater|
  sokeresultater.hashes.each do |rad|
    response.should have_tag('a', rad['Tittel'])
  end
end


Saa /^skal jeg ikke få noen treff$/ do
  response.should contain('var kompetansemaalRader = [];')
end

Saa /^jeg skal se "(.*)"$/ do |tekst|
  response.should contain(tekst)
end

Saa /^jeg skal ikke se "(.*)"$/ do |tekst|
  response.should_not contain(tekst)
end

Saa /^skal det stå "(.+)" i søkefeltet$/ do |sok|
  response.body.should have_tag('input[id=q][value=?]', sok)
end

