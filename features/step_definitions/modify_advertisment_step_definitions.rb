When /^I press "edit" for the advertisment "Cercasi chitarrista"$/ do
 # (find(:css,"#pnlActiveAdvertisments ol li", :text => "Cercasi chitarrista").find_link "edit"). click
  find(:css, "#edit_adv_1").click
end

Then /^I should be on the Edit Advertisment Page$/ do
  expect(page).to have_content "Edit Advertisement"
  expect(page).to have_css("#UpdateAdvertisment")
end
