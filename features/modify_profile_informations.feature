Feature: Generic User modifies profile informations
	As a generic user
  I can modify my profile information like username, email, and location
  Because I want to update my data


	Background: user is logged in as "Mario Rossi"
		Given Exists user "Mario Rossi" with email: "mariorossi1998@randomdomain.com" and password: "123456"
		And I am logged in as "Mario Rossi"
		And I am on the User Home Page
		And I follow "Settings"
		Then I should be on the Edit User Profile Page


  Scenario: change user"s first name and last name (happy way)
		When I fill "First Name" with "Carlo"
		And I fill "Last Name" with "Rossi"
		And I follow "Update"
		Then I should be on the User Home Page
		And I should see a feedback that confirm the changes


		Scenario: change user"s first name and last name (sad way)
			When I fill "First Name" with "carlo"			
			And I fill "Last Name" with "rossi"
			And I follow "Update"
			Then I should be on the Edit User Profile Page
			And I should see a feedback that shows error
