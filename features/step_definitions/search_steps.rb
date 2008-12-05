require File.dirname(__FILE__) + '/../support/env'

Gitt /^at jeg viser læreplaner$/ do
  visit laereplaner_path
end

Naar /^jeg velger en læreplan$/ do
  @laereplan = Laereplan.find :first
  select @laereplan.tittel, :from => "laereplaner"
end

Saa /^skal jeg se de tilhørende kompetansemålene$/ do
  @laereplan.kompetansemaal.each do |maal|
    response.body.should =~ /#{maal.tittel}/m
  end
end