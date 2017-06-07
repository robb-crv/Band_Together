And /^Exists advertisment "Cercasi chitarrista" for the band "Band di Rossi"$/ do
  marioRossiUser = User.find_by email: "mariorossi@gmail.com"
  bandRossi = Band.find_by band_manager: marioRossiUser
  adv = FactoryGirl.build(:advertisment, user: marioRossiUser, band: bandRossi, title: "Cercasi chitarrista")
  expect(adv.save).to eq true
end

And /^I should see "Cercasi chitarrista" in the "Active Advertisments" table$/ do
  expect(page).to have_css("#pnlActiveAdvertisments ol li a", :text => "Cercasi chitarrista")
end

When /^I press "delete" for the advertisment "Cercasi chitarrista"$/ do
  (find(:css,"#pnlActiveAdvertisments ol li", :text => "Cercasi chitarrista").find_link "delete"). click
end

Then /^I should not see "Cercasi chitarrista" in the "Active Advertisments" table anymore$/ do
  expect(page).not_to have_css("#pnlActiveAdvertisments ol li", :text => "Cercasi chitarrista")
end
