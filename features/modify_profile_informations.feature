Feature: Generic User modifies profile informations
	As a generic user
  I can modify my profile information like username, email, and location
  Because I want to update my data


  Scenario: change user's first name and last name [HAPPY WAY]
		Given I am on the User Home Page
		And I follow "Settings"
		Then I should be on the Edit User Profile Page
		When I fill "Name" with "Carlo"
		And I fill "Last Name" with "Rossi"
		And I follow "Update"
		Then I should be on the User Home Page
		And I should see a feedback that confirm the changes


		Scenario: change user's first name and last name [SAD WAY]
			Given I am on the User Home Page
			And I follow "Settings"
			Then I should be on the Edit User Profile Page
			When I fill "Name" with "carlo"			#andrea. qualsiasi nome che il model non convalida va bene!
			And I fill "Last Name" with "rossi"	#andrea. qualsiasi cognome che il model non convalida va bene!
			And I follow "Update"
			Then I should be on the Edit User Profile Page
			And I should see a feedback that shows error
