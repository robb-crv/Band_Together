
When /^I follow the link "Review this User"$/ do
	click_on "Review this user"
end 

Then /^I should be on the New review Page$/ do 
	expect(page.current_path).to eq reviews_new_path
end

When /^I fill star ratings with 4 stars$/ do 
	find(:css,"#4").click
end

And /^I fill in "description" with "descr"$/ do 
	fill_in("Description", with: "descr")
end

And /^I press on "Send"$/ do
	click_on "Send"
end

And /^I press on "OK" on pop-up$/ do
	begin
    	main, popup = page.driver.browser.window_handles
    	within_window(popup) do
      		click_on("OK")
    	end
  	rescue
  end
end

Then /^I should be on Giulio Bianchi profile Page$/ do
	expect(page.current_path).to eq users_show_path
	expect(page).to have_content "User's Profile"
end


