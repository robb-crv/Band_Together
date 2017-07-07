

Given /^I am on the Band Page of "Band di Rossi"$/ do
	band = Band.find_by name: "Band di Rossi"
	visit band_path(:id => band.id)
end

When /^"Giulio Bianchi" press 'Join!'$/ do
	find(:css,"#info_panel", :text => "Band di Rossi").find(:css, "#join_btn").click
end

Then /^the request has been sent and user is still on the page 'Band di Rossi'$/ do
	expect(page).to have_content("the request has been sent to the band manager")
	expect(page.current_path).to eq band_path(id: 1)
end

Then /^"Mario Rossi" see the pending request and accept it$/ do
	
	find(:css, "#pnlJoinRequests ul li").find(:css, "#_1_accept").click
	
end

Then /^"Mario Rossi" see the pending request and decline it$/ do
	#expect(page).to have_content("AAAAAA")
	find(:css, "#pnlJoinRequests ul li").find(:css, "#_1_decline").click
	
end