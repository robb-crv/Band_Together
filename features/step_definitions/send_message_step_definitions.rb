When /^I fill "Message" with "Hi Giulio, I hope you are OK"$/ do
  fill_in("Message", with: "Hi Giulio, I hope you are OK")
end

When /^I go to the Messages Page$/  do

        find(:css,"#btnDrpdownMenu").click  #andrea prima abbasso la tendina del +
      click_on "Messages"
end

Given /^"Mario Rossi" is following "Giulio Bianchi"$/ do
  giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
  marioRossiUser = User.find_by email: "mariorossi@gmail.com"
  FollowingRelationship.create(follower: marioRossiUser, followable: giulioBianchiUser)
end

When /^I follow "New Conversation"$/ do
    click_on "New Conversation"
end

When /^I select "giuliobianchi" from "To your contacts:"$/ do
    select('giuliobianchi', from: 'To your contacts:')
end


When /^I fill "Subject" with "Test Subject"$/ do
    fill_in("Subject", with: "Test Subject")
end



When /^I press "Send Message"$/ do
  click_on "Send Message"
end

Then /^I should see in the Conversations Table the conversation "Test Subject"$/ do
  expect(page).to have_css("#pnlConversations ul li a", :text => "Test Subject")
end

Given /^I am not logged in$/ do
            find(:css,"#btnDrpdownMenu").click  #andrea prima abbasso la tendina del +
        click_on "Sign Out"
end
