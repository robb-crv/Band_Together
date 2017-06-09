When /^I press "edit" for the advertisment "Cercasi chitarrista"$/ do
  (find(:css,"#pnlActiveAdvertisments ol li", :text => "Cercasi chitarrista").find_link "edit"). click
end

Then /^I should be on the Edit Advertisment Page$/ do
  expect(page).to have_content "Edit Advertisment"
  expect(page).to have_css("#UpdateAdvertisment")
end
