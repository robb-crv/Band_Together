Given /^Exists activity "Sala Prove" for the band "Band di Rossi"$/ do
  marioRossiUser = User.find_by email: "mariorossi@gmail.com"
  band = Band.find_by name: "Band di Rossi"
  activity = FactoryGirl.build(:activity, band_manager: marioRossiUser, band: band, title: "Sala Prove")
  expect(activity.save).to eq true
end

Then /^I should see "Sala Prove" in the "Band Activities" table$/ do
  expect(page).to have_css("#pnlBandActivities ol li a", :text => "Sala Prove")
end

When /^I follow the link to the "Sala Prove" activity$/ do
  click_on "Sala Prove"
end

And /^I follow "Edit"$/ do
  click_on "Edit"
end

Then /^I should be on the Edit Activity Page for "Sala Prove"$/ do
  expect(page).to have_content "Edit Activity"
    expect(page).to have_css("#UpdateActivity")
end

When /^I select as a "Duration" 1 hour$/ do
  fill_in("Duration", with: "1")
end

Then /^I should be on the Activity Page of the activity "Sala Prove" of the band "Band di Rossi"$/ do
    expect(page).to have_content "Sala Prove"
    expect(page).to have_content "Band di Rossi"

end

When /^I select as "Duration" 0 hour$/ do
  fill_in("Duration", with: "0")
end
