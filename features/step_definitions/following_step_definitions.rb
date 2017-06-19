
Given /^I am on the Profile Page of "Giulio Bianchi"$/ do
	user = User.find_by email: "giuliobianchi@gmail.com"
	visit users_show_path(:id => user.id)
end

Given /^"Mario Rossi" follows "Giulio Bianchi"$/ do 
	giulio = User.find_by email: "giuliobianchi@gmail.com"
	mario = User.find_by email: "mariorossi@gmail.com"
	click_on 'Follow'
	expect(mario.following?(giulio)).to eq(true) 
end

Given /^I should see 'Follow' button$/ do 
	expect(page).to have_selector(:link_or_button, 'Follow')
end

Given /^I should see 'Unfollow' button$/ do 
	expect(page).to have_selector(:link_or_button, 'Unfollow')
end

When /^I press 'Follow'$/ do 
	click_on 'Follow'
end

When /^I press 'Unfollow'$/ do
	click_on 'Unfollow'
end


Then /^I start to follow "Giulio Bianchi"$/ do
	giulio = User.find_by email: "giuliobianchi@gmail.com"
	mario= User.find_by email: "mariorossi@gmail.com"
	expect(mario.following?(giulio)).to eq(true)
	expect(giulio.followers).to include(mario)
end

Then /^I stop following "Giulio Bianchi"$/ do
	giulio = User.find_by email: "giuliobianchi@gmail.com"
	mario= User.find_by email: "mariorossi@gmail.com"
	expect(mario.following?(giulio)).to eq(false)
	expect(giulio.followers).not_to include(mario)
end

And /^I should see 'Unfollow' button instead of 'Follow' button$/ do
	expect(page).not_to have_selector(:link_or_button, 'Follow')
	expect(page).to have_selector(:link_or_button, 'Unfollow')
end

And /^I should see 'Follow' button instead of 'Unfollow' button$/ do
	expect(page).to have_selector(:link_or_button, 'Follow')
	expect(page).not_to have_selector(:link_or_button, 'Unfollow')
end