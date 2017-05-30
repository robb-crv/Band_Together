
#STATIC PAGES FEATURE
Given /^I am on the Home Page$/ do
    visit root_path
end

Then /^I should see "You'll never play alone"$/ do
    expect(page).to have_content "You'll never play alone"
end

When /^I follow "Contact"$/ do
    click_on "Contact"
end

When /^I follow "About"$/ do
      click_on "About"
 end

Then /^I should see Contact Page$/ do
    expect(page).to have_content "Contact"
end

Then /^I should see the About Page$/ do
    expect(page).to have_content "About"
end


#SIGN UP FEATURE
When /^I follow "Sign Up"$/ do
    click_on "Sign Up"
end

Then /^I should be on the Sign Up Page$/ do
    expect(page.current_path).to eq new_user_registration_path
end

When /^I fill in "Username" with "rossimario95"$/ do
    fill_in("Username", with: "rossimario95")
end

And /^I fill in "Email" with "mariorossi@gmail.com"$/ do
     fill_in("Email", with: "mariorossi@gmail.com")
end

And /^I fill in "Password" with "123456"$/ do
   fill_in("Password", with: "123456")
end

And /^I fill in "Password confirmation" with "123456"$/ do
   fill_in("Password confirmation", with: "123456")
end

And /^I fill in "First name" with "Mario"$/ do
    fill_in("First name", with: "Mario")
end

And /^I fill in "Last name" with "Rossi"$/ do
    fill_in("Last name", with: "Rossi")
end

And /^I fill in "Birth date" with "22-02-1955"$/ do
    fill_in("Birth date", with: "22/02/1955")
end

And /^I select "Male" from "Gender"$/ do
    find(:xpath, "//label[@for='user_gender']").click
end

And /^I select "Italy" from "nation"$/ do
    select('Italy', from: 'nation')
    page.execute_script("$('#countries').trigger('change')")
end

And /^I select "Latium" from "region"$/ do
    select('Latium', from: 'region')
end

And /^I select "Drummer" from "Instrument played"$/ do
    select("Drummer", from: "Instrument played")
end

And /^I select "Rock" from "Favourite musical genre"$/ do
    select("Rock", from: "Favourite musical genre")
end

And /^I press "Submit"$/ do

   find(:css, '#SignUp').click
end

Then /^I should be on the User Home Page$/ do
    expect(page.current_path).to eq users_home_path
end


#SIGN IN FEATURE
When /^I follow "Sign In"$/ do
    click_on "Sign In"
end

When /^I press "Sign In" button$/ do
    #click_on "Sign In"
    find(:css, '#btnLogin').click
end

Then /^I should be on the Sign In Page$/ do
    expect(page.current_path).to eq new_user_session_path
end

When /^I fill in "Email" with "rossimario@gmail.com"$/ do
  fill_in("Email", with: "rossimario@gmail.com")
end

And /^I fill in "Password" with "654321"$/ do
  fill_in("Password", with: "654321")
end

When /^I follow "Sign in with Google"$/ do
  #find(:css, "#GoogleSignIn").click
  click_on "Sign in with Google"
  #visit "users/auth/google_oauth2/callback"
end

When /^I follow "Sign in with Facebook"$/ do
   click_on "Sign in with Facebook"
end



Then /^I should see "Successfully authenticated from Facebook account."$/ do
  expect(page).to have_content "Successfully authenticated from Facebook account."
end

Then /^I should see "Successfully authenticated from Google account."$/ do
  expect(page).to have_content "Successfully authenticated from Google account."
end

Then /^I should see "Could not authenticate you"$/ do
  expect(page).to have_content "Could not authenticate you"
end

And /^I should see "Your account is locked"$/ do
  expect(page).to have_content "Your account is locked"  
end


=begin
And /^I am signed in with google$/ do

  visit user_google_oauth2_omniauth_authorize_path
end

And /^Google authorizes me$/ do
    visit user_google_oauth2_omniauth_callback_path
end

And /^I am signed in with facebook$/ do

  visit user_facebook_omniauth_authorize_path
end

And /^Facebook authorizes me$/ do

    expect(page.current_path).to eq user_facebook_omniauth_callback_path
end
=end


#LOG OUT
Given /^I am on the User Profile Page$/ do
    visit users_show_path
end

When /^I follow "Sign Out"$/ do
  #within('.button_to') do
    #find(:xpath, "//input[@id='SignOut']").click
    #click_on "Sign Out"
  #end
  #find(:css, '#SignOut', visible: false).set(true)
  find(:css, '#SignOut').click
end

Then /^I should be on the Home Page$/ do
    expect(page.current_path).to eq root_path
end

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

  expect(page.current_path).to eq users_edit_profile_informations_path
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
=begin
  user = User.find_by_email("mariorossi@gmail.com")
  puts current_path , user.email , user.username ,  user.last_name , user.first_name
  #click_on "Update"
=end
  find(:css,"#Update").click
=begin
  user2 = User.find_by_email("mariorossi@gmail.com")
  puts current_path , user2.email , user2.username ,  user2.last_name , user2.first_name
  puts user2 == nil
=end
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

Then /^I should be on the User Profile Page$/ do

  expect(page.current_path).to eq users_show_path
end

When /^I follow "Profile"$/ do

  find(:css, '#Profile').click
end

And /^I should see "PROFILO UTENTE"$/ do
  expect(page).to have_content "Profilo utente"
end
