


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


#SIGN IN FEATURE
When /^I follow "Sign Up"$/ do
    click_on "Sign Up"
end

Then /^I should be on the Sign Up Page$/ do
    page.should have_content "Sign up"
end

When /^I fill in "Name" with "Mario"$/ do
    fill_in('Name', with: 'Mario')
end

And /^I fill in "Surname" with "Rossi"$/ do
    fill_in('Surname', with: 'Rossi')
end

And /^I fill in "Username" with "rossimario95"$/ do
    fill_in('Username', with: 'rossimario95')
end
    
And /^I fill in "Email" with "mariorossi@gmail.com"$/ do
     fill_in('Email', with: 'mariorossi@gmail.com')
end
    
And /^I fill in "Birth Date" with "22-02-1955"$/ do
    fill_in('Birth Date', with: '22/02/1955')
end

And /^I select "Male" from "Sex"$/ do
    select('Male', from: 'Sex')
end

And /^I select "Italy" from "Nation"$/ do
    select('Italy', from: 'Nation')
end

And /^I select "Lazio" from "Region"$/ do
    select('Lazio', from: 'Region')
end

And /^I press "Submit"$/ do
    click_on "Submit"
end
    
Then /^I should be on the User Home Page$/ do
    page.should have_content "Top Advertisments"
end


#SIGN IN WITH GOOGLE 



