

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

Then /^I should see "A message with a confirmation link has been sent to your email address"$/ do
  expect(page).to have_content "A message with a confirmation link has been sent to your email address"
end
