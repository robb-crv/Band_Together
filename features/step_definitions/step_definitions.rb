
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

And /^I select "Male" from "Gender"$/ do
    find(:xpath, "//label[@for='user_gender']").click
end

And /^I fill in "Birth date" with "22-02-1955"$/ do
    fill_in("Birth date", with: "22/02/1955")
end


And /^I select "Italy" from "nation"$/ do
    select("Italy", from: "nation")
end

And /^I select "Latium" from "region"$/ do
    expect(page.current_path).to eq "application#states"
    select("Latium", from: "region")
end

And /^I select "Drummer" from "Instrument played"$/ do
    select("Drummer", from: "Instrument played")
end

And /^I select "Rock" from "Favourite musical genre"$/ do
    select("Rock", from: "Favourite musical genre")
end

And /^I press "Submit"$/ do
    click_on "Submit"
end

Then /^I should be on the "User Home Page"$/ do
    expect(page).to have_content "questa è l'home page che vede l'utente loggato"
end


#Sign in feature

When /^I follow "Sign In"$/ do
    click_on "Sign In"
end

Then /^I should be on the Sign In Page$/ do
    expect(page).to have_content "Log in"
end

When /^I fill in "Email" with "mariorossi@gmail.com"$/ do
     fill_in("Email", with: "mariorossi@gmail.com")
end

When /^I follow "Sign in with Google"$/ do
   click_on "Sign in with Google"
end

When /^I follow "Sign in with Facebook"$/ do
   click_on "Sign in with Facebook"
end

And /^Google authorizes me$/ do
    visit user_google_oauth2_omniauth_callback
end

And /^Facebook authorizes me$/ do
    visit user_facebook_omniauth_callback
end

#SIGN IN WITH GOOGLE


#LOG OUT
Given /^I am on the User Profile Page$/ do
    visit users_show_path
end

When /^I follow Sign Out$/ do

    #find(:css, ".btn-primary[id="SignOut"]").click
    find(:xpath, '/input[@id="SignOut"]')
end

Then /^I should be on the Home Page$/ do
    expect(page.current_path).to eq root_path
end

#MODIFY PROFILE INFORMATIONS

Given /^I am logged in as "Mario Rossi"$/ do
  user = User.new({
            :email => "mariorossi1998@randomdomain.com",
            :username => "mario1998",
            :password => "123456",
            :password_confirmation => "123456"
          })
  user.skip_confirmation!
  user.save
  visit root_path
  click_on "Sign In"
  fill_in("Email", with: "mariorossi1998@randomdomain.com")
  fill_in("Password", with: "123456")
  click_on "Log in"
  expect(page.current_path).to eq root_path     #deve stare sulla root, per essere sicuri che si è loggati, altrimenti rimane sulla login
end

And /^I am on the User Home Page$/ do

end

And /^I follow "Settings"$/ do

end

Then /^I should be on the Edit User Profile Page$/ do

end

When /^I fill "Name" with "Carlo"$/ do

end

And /^I fill "Last Name" with "Rossi"$/ do

end

And /^I follow "Update"$/ do

end

Then /^I should be on the User Home Page$/ do

end

And /^I should see a feedback that confirm the changes$/ do

end

When /^I fill "Name" with "carlo"$/ do			#andrea. qualsiasi nome che il model non convalida va bene!+
end

And /^I fill "Last Name" with "rossi"$/ do   	#andrea. qualsiasi cognome che il model non convalida va bene!

end

And /^I should see a feedback that shows error$/ do

end
