Feature: Generic User Sign Out from the application
	As a generic user
	I can Sign Out from the application clicking on button Sign Out
	because I want to exit from the application

	Scenario: Sign Out
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		And I am logged in as "Mario Rossi"
		Given I am on the User Profile Page
		When I follow "Sign Out"
		Then I should be on the Home Page
