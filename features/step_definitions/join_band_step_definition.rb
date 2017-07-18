
And /^Exists advertisment "Adv" for "Band di Rossi"$/ do 
	adv = FactoryGirl.create(:advertisment, title: "Adv", description: "description", user_id: 2, musicians: {"drummer" => 1}, band_id: 1, start_date: "2/2/2018", term_date: "2/3/2018")
end

Given /^I am on the "Adv" page$/ do 

	adv = Advertisment.find_by title: "Adv"
	visit advertisment_path(:id => adv.id)
end

Given /^I am on the Band Page of "Band di Rossi"$/ do
	band = Band.find_by name: "Band di Rossi"
	visit band_path(:id => band.id)
end

When /^"Giulio Bianchi" press 'Join!'$/ do
	find(:css,"#join_req").find(:css, "#join_btn").click
end

Then /^the request has been sent and user is still on the page 'Band di Rossi'$/ do
	expect(page).to have_content("Request was sent")
	expect(page.current_path).to eq band_path(id: 1)
end

Then /^"Mario Rossi" see the pending request and accept it$/ do
	
	find(:css, "#pnlJoinRequests ul li").find(:css, "#_1_accept").click
	expect(page).to have_content("The request has been accepted")
end

Then /^"Mario Rossi" see the pending request and decline it$/ do
	find(:css, "#pnlJoinRequests ul li").find(:css, "#_1_decline").click
	expect(page).to have_content("The request has been refused")
end


