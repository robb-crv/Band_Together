Given /^I am on the Home Page$/ do 
    visit 'static_pages/home'
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


