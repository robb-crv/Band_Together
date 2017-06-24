When /^I follow "New Band"$/ do

  find(:css,"#btnPlusDrpdown").click  #andrea prima abbasso la tendina del +
  click_on "New Band"
end

Then /^I should be on the New Band Page$/ do
  #expect(page.current_path).to eq band_new_path
  expect(page).to have_content "Create Band"
  expect(page).to have_css("#CreateBand")
end

And /^I fill "Name" with "Band di Rossi"$/ do
  fill_in("Name", with: "Band di Rossi")
end

And /^I fill "Description" with "My new band"$/ do
  fill_in("Description", with: "My new band")
end

And /^I select "Jazz" from "Musical Genre"$/ do
  select('Jazz', from: 'Musical genre')
end

And /^I press "Create"$/ do
  click_on "Create"
end

Then /^I should be on the Band Page of "Band di Rossi"$/ do
  expect(page.current_path).to eq band_show_path
  expect(page).to have_content "Band di Rossi"
end

And /^I should see "The band has been created successfully"$/ do
  expect(page).to have_content "The band has been created successfully"
end

And /^I should see an error that tells me that the object couldn't be saved$/ do
  expect(page).to have_content "There were problems with the following fields:"
end
