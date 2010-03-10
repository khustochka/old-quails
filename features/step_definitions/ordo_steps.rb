Given /^the following ordines:$/ do |ordines|
  Ordo.create!(ordines.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) ordo$/ do |pos|
  visit ordines_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following ordines:$/ do |expected_ordines_table|
  expected_ordines_table.diff!(tableish('table tr', 'td,th'))
end
