Feature:
	As a Generic User
	I can see user's information (like username, email, birth date etc )

	Background:
		Given I am on the Home Page
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		When I follow "Sign In"
		Then I should be on the Sign In Page
		When I fill in "Email" with "mariorossi@gmail.com"
		And I fill in "Password" with "123456"
		When I press "Sign In" button
		Then I should be on the User Home Page


	Scenario: Show profile info
		Given I am on the User Home Page
		When I follow "Profile"
		Then I should be on the User Profile Page
		And I should see "PROFILO UTENTE"
