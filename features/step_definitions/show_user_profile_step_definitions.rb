


Then /^I should be on the User Profile Page$/ do

  expect(page.current_path).to eq users_show_path
end

When /^I follow "Profile"$/ do

  find(:css, '#Profile').click
end

And /^I should see "User's Profile"$/ do
  expect(page).to have_content "User's Profile"
end
