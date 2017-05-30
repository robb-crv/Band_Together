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

And /^I follow "Admin Dashboard"$/ do 
	find(:css, '#AdminDashboard').click	
end

Then /^I should be on the Admin Dashboard$/ do 
	expect(page.current_path).to eq rails_admin_path
end

And /^I follow "Users"$/ do
	find(:xpath, "//a[@href='/admin/user']").click
end

Then /^I should be on the Users Index$/ do 
	expect(page.current_path).to eq rails_admin.index_path(model_name: 'user')
	visit rails_admin.index_path(model_name: 'user')
end

#Ban User

When /^I follow "Ban this user" on user "Mario Rossi"$/ do 
	page.all(:css, 'li.icon.ban_user_account_member_link')[0].click
end

Then /^user "Mario Rossi" should be banned$/ do
	$stdout.puts(page.body) 
	user = User.find_by_email("mariorossi@gmail.com")
	expect(user.banned).to eq true	
end








  
  
