Så /^skal jeg kunne se (\d+) læreplaner$/ do |antall|
  response.should have_tag("li.liste_element_laereplan", antall.to_i)
end

Så /^skal jeg se følgende læreplan øverst "(.*)"$/ do |laereplan_tittel|
  response.should have_tag("li.liste_element_laereplan", /#{laereplan_tittel}/m)
end