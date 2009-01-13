
Gitt /^at jeg er på hovedsiden$/ do
  visit root_path
end

Gitt /^at jeg er på læreplan søkesiden$/ do
  visit laereplansok_index_path
end

Saa /^skal jeg bli tatt til hovedsiden$/ do
  request.path_parameters[:controller].should == "info"
  request.path_parameters[:action].should == "index"
end

