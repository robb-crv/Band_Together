And /^Exists band "Band di Rossi" created by user "Mario Rossi"$/ do
  marioRossiUser = User.find_by email: "mariorossi@gmail.com"
  band = FactoryGirl.build(:band, name: "Band di Rossi", band_manager: marioRossiUser)
  expect(band.save).to eq true
end

And /^"Giulio Bianchi" is a member of "Band di Rossi"$/ do
  giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
  rossiBand = Band.find_by name: "Band di Rossi"
  giulioBianchiUser.joined_bands << rossiBand
end

And /^Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"$/ do
  user = FactoryGirl.build(:user, email: "giuliobianchi@gmail.com", password: "123456")
  user.skip_confirmation!
  expect(user.save).to eq true
end

And /^Exists user "Utente Generico" with email: "generic@email.com" and password: "123456"$/ do
  user = FactoryGirl.build(:user, email: "generic@email.com", password: "123456")
  user.skip_confirmation!
  expect(user.save).to eq true
end

Given /^I am logged in as "Utente Generico"$/ do
  visit root_path
  click_on "Sign In"
  fill_in("Email", with: "generic@email.com")
  fill_in("Password", with: "123456")
  find(:css, '#btnLogin').click
  expect(page.current_path).to eq users_home_path
end

When /^I search for the band "Band di Rossi"$/ do

end


Then /^I should see the "Join Band" link$/ do
  expect(page).to have_content "Join Band"
end

Then /^I should see "Band di Rossi" in the "Created Bands" table$/ do

  expect(page).to have_css("#pnlCreatedBands ol li a:contains(Band.di.Rossi)")
end

When /^I follow the link to "Band di Rossi"$/ do
    click_on "Band di Rossi"
end

Then /^I should see the "Edit Band Informations" link$/ do
  expect(page).to have_content "Edit Band Informations"
end


Given /^I am logged in as "Giulio Bianchi"$/ do
  visit root_path
  click_on "Sign In"
  fill_in("Email", with: "giuliobianchi@gmail.com")
  fill_in("Password", with: "123456")
  find(:css, '#btnLogin').click
  expect(page.current_path).to eq users_home_path
end

Then /^I should see "Band di Rossi" in the "Joined Bands" table$/ do

end

Then /^I should see the "Leave Band" link$/ do
  expect(page).to have_content "Leave Band"
end
