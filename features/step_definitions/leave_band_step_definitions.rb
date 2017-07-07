Given /^"Giulio Bianchi" is member of "Band di Rossi"$/ do
  giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
  bandDiRossi = Band.find_by name: "Band di Rossi"
  MemberAssociation.create(user: giulioBianchiUser, joined_band: bandDiRossi)
end

When /^I press "Leave Band"$/ do
  click_on "Leave Band"
end

Then /^I should be redirected to the band "Band di Rossi"$/ do
  expect(page).to have_css("#info_panel")
  expect(page).to have_content "Band di Rossi"
end

Then /^I should not be member of "Band di Rossi" anymore$/ do
  giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
  bandDiRossi = Band.find_by name: "Band di Rossi"
  rel = MemberAssociation.where(user: giulioBianchiUser, joined_band: bandDiRossi)
  expect(rel.empty?).to eq true
end
