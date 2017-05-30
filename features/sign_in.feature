Feature: Generic User signs in on the application
	As a generic user
	I can sign in in the application providing my personal email and password
	because I want to access to my personal account

	Scenario: Sign in via the application (happy way)
		Given I am on the Home Page
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		When I follow "Sign In"
		Then I should be on the Sign In Page
		When I fill in "Email" with "mariorossi@gmail.com"
		And I fill in "Password" with "123456"
		When I press "Sign In" button
		Then I should be on the User Home Page

	Scenario: Sign in via the application (sad way)
		Given I am on the Home Page
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		When I follow "Sign In"
		Then I should be on the Sign In Page
		When I fill in "Email" with "rossimario@gmail.com"
		And I fill in "Password" with "654321"
		When I press "Sign In" button
		Then I should be on the Sign In Page

	Scenario: Sign in via the application (banned user)
		Given I am on the Home Page
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456" that is banned
		When I follow "Sign In"
		Then I should be on the Sign In Page
		When I fill in "Email" with "mariorossi@gmail.com"
		And I fill in "Password" with "123456"
		When I press "Sign In" button
		Then I should be on the Sign In Page
		And I should see "Your account is locked"


 	@omniauth_test
	Scenario: Sign in via Google (happy way)
		Given I am on the Home Page
		When I follow "Sign In"
		Then I should be on the Sign In Page
		When I follow "Sign in with Google"
		Then I should see "Successfully authenticated from Google account."

		@omniauth_test_failure
	 	Scenario: Sign in via Google (sad way)
	 		Given I am on the Home Page
	 		When I follow "Sign In"
	 		Then I should be on the Sign In Page
	 		When I follow "Sign in with Google"
	 		Then I should see "Could not authenticate you"



	@omniauth_test
	Scenario: Sign in via Facebook (happy way)
		Given I am on the Home Page
		When I follow "Sign In"
		Then I should be on the Sign In Page
		When I follow "Sign in with Facebook"
		Then I should see "Successfully authenticated from Facebook account."

		@omniauth_test_failure
		Scenario: Sign in via Facebook (sad way)
			Given I am on the Home Page
			When I follow "Sign In"
			Then I should be on the Sign In Page
			When I follow "Sign in with Facebook"
			Then I should see "Could not authenticate you"
