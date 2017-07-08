
Then /^I should be on the new request page$/ do 
	expect(page.current_path).to eq new_join_request_path
end

When /^"Mario Rossi" press 'Invite people!'$/ do
	find(:css, "#invite_btn").click
end

Then /^"Giulio Bianchi" see the pending invitation and accept it$/ do
	(find(:css,"#info_panel", :text => "Band di Rossi").find_link "yes"). click
end

Then /^"Giulio Bianchi" see the pending invitation and decline it$/ do
	(find(:css,"#info_panel", :text => "Band di Rossi").find_link "no"). click
end

And /^I fill "Username" with 'giuliobianchi'$/ do 
	fill_in("Username", with: "giuliobianchi")
end

And /^I press "Send"$/ do
	click_on "Send"
end