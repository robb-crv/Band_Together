
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
    click_on "Submit"
end
 
Then /^I should be on the User Home Page$/ do
    expect(page).to have_content "questa è l'home page che vede l'utente loggato"
end
 
 
#Sign in feature
 
When /^I follow "Sign In"$/ do
    click_on "Sign In"
end
 
Then /^I should be on the Sign In Page$/ do
    expect(page.current_path).to eq new_user_session_path 
end
 
 
When /^I follow "Sign in with Google"$/ do
  #$stdout.puts current_path
  #Omniauth.config.test_mode = true

  Capybara.default_host = "http://example.com"
  Capybara.current_driver = :webkit

  OmniAuth.config.add_mock(:google_oauth2, {
      :uid => '12345',
      :info => {
          :name => 'googleuser'
      }
    })

  #within("//div[@id='oauth']") do
    #find(:css, "#GoogleSignIn").click 
    #find_link("Sign in with Google", href: "/users/auth/google_oauth2").click
  #end
  visit new_user_session_path
  find(:css, "#GoogleSignIn").click
end
 
When /^I follow "Sign in with Facebook"$/ do
   click_on "Sign in with Facebook"
end
 
And /^Google authorizes me$/ do
    visit user_google_oauth2_omniauth_callback_path
end
 
And /^Facebook authorizes me$/ do
    visit user_facebook_omniauth_callback_path
end
 
 
 
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
  user = User.new({
            :email => "mariorossi@gmail.com",
            :username => "mario",
            :password => "123456",
            :password_confirmation => "123456"
          })
  user.skip_confirmation!
  expect(user.save).to eq true
end
 
And /^I am logged in as "Mario Rossi"$/ do
  visit root_path
  click_on "Sign In"
  fill_in("Email", with: "mariorossi@gmail.com")
  fill_in("Password", with: "123456")
  click_on "Sign In"
  expect(page.current_path).to eq root_path     #deve stare sulla root, per essere sicuri che si è loggati, altrimenti rimane sulla login
end
 
And /^I am on the User Home Page$/ do
  visit root_path
  expect(page).to have_content "questa è l'home page che vede l'utente loggato"
end
 
And /^I follow "Settings"$/ do
 
end
 
Then /^I should be on the Edit User Profile Page$/ do
 
end
 
When /^I fill "First Name" with "Carlo"$/ do
 
end
 
And /^I fill "Last Name" with "Rossi"$/ do
 
end
 
And /^I follow "Update"$/ do
 
end
 
 
And /^I should see a feedback that confirm the changes$/ do
 
end
 
When /^I fill "First Name" with "carlo"$/ do
end
 
And /^I fill "Last Name" with "rossi"$/ do
 
end
 
And /^I should see a feedback that shows error$/ do
 
end


#SHOW PROFILE INFORMATIONS

When /^I follow "Profile"$/ do 

  find(:css, '#Profile').click
end

Then /^I should be on the User Profile Page$/ do

  expect(page.current_path).to eq users_show_path
end

And /^I should see "PROFILO UTENTE"$/ do
  expect(page).to have_content "Profilo utente"
end