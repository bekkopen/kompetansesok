Så /^skal jeg kunne se (\d+) læreplaner$/ do |antall|
  response.should have_tag("tbody > tr", antall.to_i)
end

Så /^skal jeg se følgende læreplan øverst "(.*)"$/ do |laereplan_tittel|
  response.should have_tag("tbody > tr", /#{laereplan_tittel}/m)
end