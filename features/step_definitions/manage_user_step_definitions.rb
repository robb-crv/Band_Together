#Background

Given /^Exists admin user "Admin" with email: "admin@email.com" and password: "admin1"$/ do
	user = FactoryGirl.build(:admin)
	user.skip_confirmation!
  	expect(user.save).to eq true
end

And /^I am logged in as "Admin"$/ do
	visit root_path
	click_on "Sign In"
	fill_in("Email", with: "admin@email.com")
	fill_in("Password", with: "admin1")
	click_on "Sign In"
	expect(page.current_path).to eq users_home_path     #deve stare sulla root, per essere sicuri che si è loggati, altrimenti rimane sulla login
end

And /^I am on the User Home Page$/ do
	expect(page.current_path).to eq users_home_path
end

And /^I follow "Admin Dashboard"$/ do |variable|
	find(:css, '#AdminDashboard').click	
end

Then /^I should be on the Admin Dashboard$/ do |variable|
	expect(page.current_path).to eq rails_admin.dashboard_path	
end

And /^I follow "Users"$/ do
	click_on "Users"
end

Then /^I should be on the Users Index$/ do |variable|
	expect(page.current_path).to eq rails_admin.index_path(model_name: 'users')	
end






  
  
