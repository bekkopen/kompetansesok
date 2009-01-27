Gitt /^at jeg er på hovedsiden$/ do
  visit root_path
end

Gitt /^at jeg er på infosiden$/ do
  visit info_index_path
end

Når /jeg klikker "(.+)"/ do |knapp|
  click_button knapp
end

Når /jeg klikker på linken "(.+)"/ do |link|
  click_link link
end

Når /^jeg velger (\w+) "(.*)"$/ do |type, link|
  click_link link
end


Gitt /^at jeg ser på (.*) med uuid (.+)$/ do |kontroller, uuid|
  visit url_for(:controller => kontroller, :action => :show, :id => uuid)
end

Så /^(?:skal jeg|jeg skal) bli tatt til hovedsiden$/ do
  request.path_parameters[:controller].should == "sok"
  request.path_parameters[:action].should == "index"
end

Gitt /^jeg har markert følgende:$/ do |table|
  table.hashes.each do |config|
    config.each do |checkbox, value|
      box = "vis_#{checkbox}"
      if value == 'true'
        check box
      else
        uncheck box
      end
    end
  end
end

Så /^skal filtreringsboksene vise seksjoner:$/ do |table|
  table.hashes.each do |config|
    config.each do |checkbox, value|
      response.should have_selector("#vis_#{checkbox}") { |box|
        if value == 'true'
          raise "Checkbox #{checkbox} should be checked" if box.attr('checked') != 'checked'
        else
          raise "Checkbox #{checkbox} should be unchecked" if box.attr('checked') == 'checked'
        end
        true
      }
    end
  end
end

Så /^(?:skal jeg|jeg skal) se "(.+)" på plass "(\d+)" i brødsmulestien$/ do |tekst, plass|
  response.should have_selector("#brodsmulesti > span:nth-child(#{plass})") do |smule|
    smule.should contain(tekst)
  end
end

