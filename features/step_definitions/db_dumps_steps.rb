
Saa /^skal jeg se en liste over database dumps$/ do
  request.should have_tag('#db_liste') do |content|
    content.should contain('.zip')
  end
end


