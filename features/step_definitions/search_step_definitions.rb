When /^I fill the search bar with "Mario"$/ do 
	fill_in("Search", with: "Mario")
	find('#search-form').send_keys(:enter)	
end


Then /^I should be on the Search Index Page$/ do 
	expect(page.current_path).to eq search_index_path	
end

And /^I should see "Adv" as a result$/ do 
	expect(page).to have_content "Adv"	
end

When /^I follow Users$/ do 
	find(:css, "#user-tab", text: "Users").click	
end

Then /^I should see "Mario Rossi" as a result$/ do 
	expect(page).to have_content "mariorossi@gmail.com"	
end

When /^I follow Bands$/ do 
	find(:css, "#band-tab", text: "Bands").click	
end

Then /^I should see "Band di Rossi" as a result$/ do 
	expect(page).to have_content "Band di Rossi"	
end
