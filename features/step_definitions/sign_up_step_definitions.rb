
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

And /^I select "Italy" from "Nation"$/ do
    select('Italy', from: 'nation')
    page.execute_script("$('#countries').trigger('change')")
    wait_for_ajax
end

And /^I select "Latium" from "Region"$/ do
    select('Latium', from: 'region')
    page.execute_script("$('#states-of-country').trigger('change')")
    wait_for_ajax
end

And /^I select "Rome" from "City"$/ do
  select('Rome', from: 'city')
  page.execute_script("$('#city-of-region').trigger('change')")
  wait_for_ajax
end

And /^I select "Drummer" from "Instrument played"$/ do
    select("Drummer", from: "Instrument Played")
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
