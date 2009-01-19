Gitt /^at jeg er på hovedsiden$/ do
  visit root_path
end

Gitt /^at jeg er på læreplan søkesiden$/ do
  visit laereplansok_index_path
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
      if value.blank?
        uncheck box
      else
        check box
      end
    end
  end
end


Saa /^skal filtreringsboksene huske instillinger:$/ do |table|
  table.hashes.each do |config|
    config.each do |checkbox, value|
      value = nil if value.blank?
      response.should have_selector("#filter_#{checkbox}") { |box|
        box.attr('checked').should == value
      }
    end
  end
end
