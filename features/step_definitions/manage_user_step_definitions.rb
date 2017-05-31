#Background

Given /^Exists admin user "Admin" with email: "admin@email.com" and password: "admin1"$/ do
	user = FactoryGirl.build(:admin)
	user.skip_confirmation!
  	expect(user.save).to eq true
end

Given /^I am logged in as "Admin"$/ do
	visit root_path
	click_on "Sign In"
	fill_in("Email", with: "admin@email.com")
	fill_in("Password", with: "admin1")
	find(:css, '#btnLogin').click
	expect(page.current_path).to eq users_home_path     #deve stare sulla root, per essere sicuri che si è loggati, altrimenti rimane sulla login
end

Then /^I should see "Admin"$/ do
	expect(page).to have_content "Admin"	
end

Then /^I should not see "Admin"$/ do
	expect(page).to have_no_content "Admin"	
end

And /^I follow "Admin"$/ do 
	find(:css, 'a.page-scroll').click	
end

Then /^I should be on the Admin Dashboard$/ do 
	expect(page.current_path).to eq rails_admin_path
end









  
  
