Gitt /^at jeg er på hovedsiden$/ do
  visit root_path
end

Gitt /^at jeg er på infosiden$/ do
  visit info_index_path
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
