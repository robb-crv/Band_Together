


#STATIC PAGES FEATURE
Given /^I am on the Home Page$/ do
    visit root_path
end

Then /^I should see "You'll never play alone!"$/ do
    page.should have_content "You'll never play alone!"
end

When /^I follow "Contacts"$/ do
    click_on "Contacts"
end

 When /^I follow "About"$/ do
      click_on "About"
 end

Then /^I should see Contact Page$/ do
    page.should have_content "Contacts"
end

Then /^I should see the About Page$/ do
    page.should have_content "About"
end


#SIGN UP FEATURE
When /^I follow "Sign Up"$/ do
    click_on "Sign Up"
end

Then /^I should be on the Sign Up Page$/ do
    page.should have_content "Sign up"
end

When /^I fill in "Username" with "rossimario95"$/ do
    fill_in('Username', with: 'rossimario95')
end

And /^I fill in "Email" with "mariorossi@gmail.com"$/ do
     fill_in('Email', with: 'mariorossi@gmail.com')
end

And /^I fill in 'Password' with '123456'$/ do
   fill_in('Password', with: '123456')
end

And /^I fill in 'Password confirmation' with '123456'$/ do
   fill_in('Password confirmation', with: '123456')
end

And /^I fill in "First name" with "Mario"$/ do
    fill_in('First name', with: 'Mario')
end

And /^I fill in "Last name" with "Rossi"$/ do
    fill_in('Last name', with: 'Rossi')
end

And /^I select "Male" from "Gender"$/ do
    select('Male', from: 'Gender')
end

And /^I fill in "Birth date" with "22-02-1955"$/ do
    fill_in('Birth date', with: '22/02/1955')
end


And /^I select "Italy" from "nation"$/ do
    select('Italy', from: 'nation')
end

And /^I select "Latium" from "region"$/ do
    select('Latium', from: 'region')
end

And /^I select "Drummer" from "Instrument played"$/ do
    select('Drummer', from: 'Instrument played')
end

And /^I select "Rock" from "Favourite musical genre"$/ do
    select('Rock', from: 'Favourite musical genre')
end

And /^I press "Submit"$/ do
    click_on "Submit"
end

Then /^I should be on the User Home Page$/ do
    page.should have_content "questa è l'home page che vede l'utente loggato"
end


#Sign in feature

When /^I follow "Sign In"$/ do
    click_on "Sign In"
end

Then /^I should be on the Sign In Page$/ do
    page.should have_content "Log in"
end

When /^I fill in 'Email' with 'mariorossi@gmail.com'$/ do
     fill_in('Email', with: 'mariorossi@gmail.com')
end

And /^I fill in 'Password' with '123456'$/ do
   fill_in('Password', with: '123456')
end

When /^I follow 'Sign in with Google'$/ do
   click_on "Sign in with Google"
end

When /^I follow 'Sign in with Facebook'$/ do
   click_on "Sign in with Facebook"
end

And /^Google authorizes me$/ do
    visit user_google_oauth2_omniauth_callback
end

And /^Facebook authorizes me$/ do
    visit user_facebook_omniauth_callback    
end 
