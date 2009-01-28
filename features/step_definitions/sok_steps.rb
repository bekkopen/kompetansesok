
Når /^jeg søker etter "(.*)"$/ do |sok|
  fill_in 'Søk', :with => sok
  click_button 'Søk'
end

Så /^skal jeg få opp følgende treff i kompetansemål:$/ do |sokeresultater|
  sokeresultater.hashes.each do |rad|
    response.should contain(encode(rad['Tittel starter med']))
  end
end

Så /^skal jeg få opp følgende treff for (\w+):$/ do |type, sokeresultater|
  sokeresultater.hashes.each do |rad|
    response.should have_tag('a', rad['Tittel'])
  end
end

Så /^skal jeg få advarsel om at søket er for grovt$/ do
  response.should contain(I18n.t('feilmelding.for_grovt_søk'))
end

Så /^skal jeg ikke få advarsel om at søket er for grovt$/ do
  response.should_not contain(I18n.t('feilmelding.for_grovt_søk'))
end

Så /^skal jeg ikke få noen treff$/ do
  response.should contain('var kompetansemaalRader = [];')
end

Så /^jeg skal se "(.*)"$/ do |tekst|
  response.should contain(tekst)
end

Så /^jeg skal ikke se "(.*)"$/ do |tekst|
  response.should_not contain(tekst)
end

Så /^skal det stå "(.+)" i søkefeltet$/ do |sok|
  response.should have_tag('input[id=q][value=?]', sok)
end

Så /^skal jeg få følgende antall treff:$/ do |treff_tabell|
  treff_tabell.hashes.each do |rad|
    response.should have_tag('h2', "#{rad['Type']} (antall treff: #{rad['Antall']})")
  end
end


