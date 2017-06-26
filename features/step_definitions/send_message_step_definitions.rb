When /^I go to the Messages Page$/  do

        find(:css,"#btnDrpdownMenu").click  #andrea prima abbasso la tendina del +
      click_on "Messages"
end

When /^I follow "New Conversation"$/ do
  pending # Write code here that turns the phrase above into concrete actions
end

When /^I fill "To" with "giuliobianchi@gmail.com"$/ do

end


When /^I fill "Subject" with "Test Subject"$/ do

end

When /^I fill "Body" with "Hi Giulio, are you OK?"$/ do

end

When /^I press "Send Message"$/ do

end

Then /^I should see in the Conversations Table the conversation "Test Subject"$/ do

end

Given /^I am not logged in$/ do

end
