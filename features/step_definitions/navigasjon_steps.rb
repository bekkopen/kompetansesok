Gitt /^at jeg er på hovedsiden$/ do
  visit root_path
end

Naar /jeg klikker "(.+)"/ do |knapp|
  click_button knapp
end

Gitt /^at jeg ser på (.*) med uuid (.+)$/ do |kontroller, uuid|
  visit url_for(:controller => kontroller, :action => :show, :id => uuid)
end

Saa /^skal jeg bli tatt til hovedsiden$/ do
  request.path_parameters[:controller].should == "sok"
  request.path_parameters[:action].should == "index"
end

Gitt /^jeg har markert følgende:$/ do |table|
  table.hashes.each do |config|
    config.each do |checkbox, value|
      box = "filter_#{checkbox}"
      if value == 'true'
        check box
      else
        uncheck box
      end
    end
  end
end


Saa /^skal filtreringsboksene vise seksjoner:$/ do |table|
  table.hashes.each do |config|
    config.each do |checkbox, value|
      response.should have_selector("#filter_#{checkbox}") { |box|
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
