Feature: User could follow or unfollow another user

	As a generic user
	I can follow/unfollow other user
	because I want to follow/unfollow their activities 

	Background: user "Mario Rossi" is logged in, he's watching "Giulio Bianchi" profile

		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  		And I am logged in as "Mario Rossi"
  		Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
  		Given I am on the Profile Page of "Giulio Bianchi"

	Scenario: "Mario Rossi" start following "Giulio Bianchi"
		Given I should see 'Follow' button
		When I press 'Follow'
		Then I start to follow "Giulio Bianchi"
		And I should see 'Unfollow' button instead of 'Follow' button

	Scenario: "Mario Rossi" stop following "Giulio Bianchi"
		Given "Mario Rossi" follows "Giulio Bianchi"
		Given I should see 'Unfollow' button
		When I press 'Unfollow'
		Then I stop following "Giulio Bianchi"
		And I should see 'Follow' button instead of 'Unfollow' button
