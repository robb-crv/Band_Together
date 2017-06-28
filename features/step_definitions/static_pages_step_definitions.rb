
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
