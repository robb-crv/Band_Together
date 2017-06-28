
#MODIFY PROFILE INFORMATIONS

Given /^Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"$/ do

  user = FactoryGirl.build(:user, email: "mariorossi@gmail.com", password: "123456")
  user.skip_confirmation!
  expect(user.save).to eq true
end

Given /^Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456" that is banned$/ do

  user = FactoryGirl.build(:invalid_user, email: "mariorossi@gmail.com", password: "123456")
  user.skip_confirmation!
  expect(user.save).to eq true
end

And /^I am logged in as "Mario Rossi"$/ do
  visit root_path
  click_on "Sign In"
  fill_in("Email", with: "mariorossi@gmail.com")
  fill_in("Password", with: "123456")
  find(:css, '#btnLogin').click
  expect(page.current_path).to eq users_home_path     #deve stare sulla root, per essere sicuri che si è loggati, altrimenti rimane sulla login
end

And /^I am on the User Home Page$/ do
    expect(page.current_path).to eq users_home_path
end

And /^I follow "Settings"$/ do
  click_on "Settings"
end
=begin
Then /^I should be on the Edit User Profile Page$/ do

    expect(page).to have_content "Edit User"
end
=end
Then /^I should be on the Edit User Profile Informations Page$/ do

    expect(page).to have_content "Edit Profile Informations"
  #expect(page.current_path).to eq users_edit_profile_informations_path

end

When /^I fill "First name" with "Carlo"$/ do
  fill_in("First name", with: "Carlo")
end

And /^I fill "Last name" with "Rossi"$/ do
  fill_in("Last name", with: "Rossi")
end

And /^I fill "Current password" with "123456"$/ do
  fill_in("Current password", with: "123456")
end

And /^I follow "Update"$/ do
  click_on "Update"
end




And /^I should see a feedback that confirm the changes$/ do
  expect(page).to have_css(".alert-success")
end

And /^I should see a feedback that shows error$/ do
   expect(page).to have_css(".alert-danger")
end



When /^I fill "First name" with "carlo"$/ do
  fill_in("First name", with: "carlo")
end

And /^I fill "Last name" with "rossi"$/ do
  fill_in("Last name", with: "rossi")
end
