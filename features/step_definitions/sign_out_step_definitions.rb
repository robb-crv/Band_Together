
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
