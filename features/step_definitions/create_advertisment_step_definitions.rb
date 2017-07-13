And /^I follow "New Advertisment"$/ do
    click_on "New Advertisment"
end

Then /^I should be on the New Advertisment Page$/ do
  #expect(page.current_path).to eq advertisment_new_path
    expect(page).to have_content "Create Advertisement for the band"
      expect(page).to have_css("#CreateAdvertisment")
end

When /^I fill in "Title" with "Cercasi chitarrista"$/ do
  fill_in("Title", with: "Jazz Band")
end

And /^I fill in "Description" with "La Band di Rossi cerca chitarrista con passione per il rock"$/ do
  fill_in("Description", with: "La Band di Rossi cerca chitarrista con passione per il rock")
end

And /^I select as a "Term Date" 1 month ago$/ do
  unMeseFa = Time.now - 1.month
  fill_in("Term date", with: unMeseFa)
end

And /^I select as a "Term Date" 1 month from now$/ do
  fra1Mese = Time.now + 1.month
  fill_in("Term date", with: fra1Mese)
end

Then /^I should be on the Advertisment Page of the advertisment "Cercasi chitarrista" of the band "Band di Rossi"$/ do
    expect(page).to have_content "La Band di Rossi cerca chitarrista con passione per il rock"
end

And /^I press on "Create"$/ do
  click_on "Create"
end

And /^I select "Lead Guitarist" and "Bass Guitarist" as "Musicians Needed"$/ do

  fill_in("advertisment[musicians][drummer]", with: 1)
  fill_in("advertisment[musicians][bass_guitarist]", with: 1)
end
