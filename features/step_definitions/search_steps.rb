require File.dirname(__FILE__) + '/../support/env'

Gitt /^at jeg viser læreplaner$/ do
  visit laereplaner_path
end

Naar /^jeg velger Læreplan "(.*)"$/ do |laereplan_tittel|
  click_link laereplan_tittel
end

Saa /^skal jeg se (\d+) kompetansemål$/ do |n|
  response.should have_selector('table#kompetansemaal') { |tables|
    tables.length.should == 1
    tables.first.should have_selector('tbody > tr') { |rader|
      rader.length.should == n.to_i
    }
  }
end

Saa /^jeg skal se følgende spesifikke kompetansemål:$/ do |tabell|
  tabell.hashes.each do |kompetansemaal|
    response.should contain(kompetansemaal['tittel'])
  end
end
