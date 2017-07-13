Then /^I should start to follow "Band di Rossi"$/ do
	giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
	bandDiRossi = Band.find_by name: "Band di Rossi"
	rel = FollowingRelationship.where(follower: giulioBianchiUser, followable: bandDiRossi)
	expect(rel.empty?).to eq false
end

Given /^"Giulio Bianchi" follows "Band di Rossi"$/ do
	giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
  bandDiRossi = Band.find_by name: "Band di Rossi"
  expect(FollowingRelationship.create(follower: giulioBianchiUser, followable: bandDiRossi)).not_to eq nil
end

When /^I press 'Follow the Band!'$/ do
	click_on "Follow the Band!"
end

When /^I press 'Unfollow the Band'$/ do
	click_on "Unfollow the Band"
end


Then /^I should stop following "Band di Rossi"$/ do
	giulioBianchiUser = User.find_by email: "giuliobianchi@gmail.com"
	bandDiRossi = Band.find_by name: "Band di Rossi"
	rel = FollowingRelationship.where(follower: giulioBianchiUser, followable: bandDiRossi)
	expect(rel.empty?).to eq true
end
