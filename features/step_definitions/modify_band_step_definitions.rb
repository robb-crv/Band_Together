 Then /^I should be on the Edit Band Page of "Band di Rossi"$/ do
   expect(page).to have_content "Edit Band"
     expect(page).to have_css("#UpdateBand")
 end

 When /^I fill "Description" with "New Description"$/ do
   fill_in("Description", with: "New Description")
 end

And /^I should see "New Description" for the field "Description"$/ do
   expect(page).to have_content "Description: New Description"
end

When /^I visit my Profile Page$/ do

      find(:css,"#btnDrpdownMenu").click  #andrea prima abbasso la tendina del +
    click_on "Profile"
end


When /^I press "edit" for the band "Band di Rossi"$/ do
  (find(:css,"#pnlCreatedBands ol li", :text => "Band di Rossi").find_link "edit"). click
end

 And /^I should see "Rome" for the field "City"$/ do
   expect(page).to have_content "Active in: Rome, Latium, Italy"
 end
