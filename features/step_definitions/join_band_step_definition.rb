

Given /^I am on the Band Page of "Band di Rossi"$/ do
	band = Band.find_by name: "Band di Rossi"
	visit band_path(:id => band.id)
end

When /^"Mario Rossi" press 'Join!'$/ do
	find(:css,"#info_panel", :text => "Band di Rossi").find(:css, "#join_req").click
	expect(page.current_path).to eq band_path(id: 1)
end

Then /^the request has been sent and user is still on the page 'Band di Rossi'$/ do
	expect(page.current_path).to eq band_path(id: 1)
end