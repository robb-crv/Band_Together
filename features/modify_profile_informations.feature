Feature: Generic User modifies profile informations
	As a generic user
  I can modify my profile information like username, email, and location
  Because I want to update my data


	Background: user is logged in as "Mario Rossi" and he is in the edit profile page
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		And I am logged in as "Mario Rossi"
		And I am on the User Home Page
		And I follow "Settings"
		Then I should be on the Edit User Profile Informations Page


  Scenario: change user's first name and last name (happy way)
		When I fill "First name" with "Carlo"
		And I fill "Last name" with "Rossi"
		#And I fill "Current password" with "123456" #andrea. non serve più
		And I follow "Update"
		Then I should be on the User Home Page
		And I should see a feedback that confirm the changes


		Scenario: change user's first name and last name using invalid parameters (sad way)
			When I fill "First name" with "carlo"
			And I fill "Last name" with "rossi"
			#And I fill "Current password" with "123456"
			And I follow "Update"
			Then I should be on the Edit User Profile Informations Page
			And I should see a feedback that shows error
