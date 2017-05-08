Given /^I am on the home page$/ do 
    visit "/"
end

Then /^I should see "Home page"$/ do
    page.should have_content "Home page"
end
