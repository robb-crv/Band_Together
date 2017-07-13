Feature: User could follow or unfollow a band

	As a generic user
	I can follow/unfollow band
	because I want to follow/unfollow their activities

	Background: user "Mario Rossi" has created a band "Band di Rossi" and exists user "Giulio Bianchi"

		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
    And Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
    And Exists band "Band di Rossi" created by user "Mario Rossi"
    And I am logged in as "Giulio Bianchi"


	Scenario: "Giulio Bianchi" start following "Band di Rossi"
    And I am on the Band Page of "Band di Rossi"
		When I press 'Follow the Band!'
		Then I should start to follow "Band di Rossi"
		And I should see 'Unfollow' button instead of 'Follow' button

	Scenario: "Giulio Bianchi" stop following "Band di Rossi"
		Given "Giulio Bianchi" follows "Band di Rossi"
    And I am on the Band Page of "Band di Rossi"
		When I press 'Unfollow the Band'
		Then I should stop following "Band di Rossi"
		And I should see 'Follow' button instead of 'Unfollow' button
