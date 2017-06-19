
Given /^I am on the Profile Page of "Giulio Bianchi"$/ do
	user = User.find_by email: "giuliobianchi@gmail.com"
	visit users_show_path(:id => user.id)
end


When /^I press 'Follow'$/ do 
	click_on 'Follow'
end

When /^I press 'Un-Follow'$/ do
	expect(page.current_path).to eq users_show_path 
	#click_on 'Un-Follow'
	expect(page.current_path).to have_content()
end


Then /^I start to follow "Giulio Bianchi"$/ do
	giulio = User.find_by email: "giuliobianchi@gmail.com"
	mario= User.find_by email: "mariorossi@gmail.com"
	expect(mario.following?(giulio)).to eq(true)
	#expect(giulio.followers).to include(mario)
end

Then /^I stop following "Giulio Bianchi"$/ do

	giulio = User.find_by email: "giuliobianchi@gmail.com"
	mario= User.find_by email: "mariorossi@gmail.com"
	expect(mario.following?(giulio)).to eq(false)
end