Feature: Admin manages user information via Rails_Admin Dashboard
	As Admin
	I can manage user information 
	because I want to modify his data stored in the application

	Background: An Admin and a user exist in the application
		Given Exists admin user "Admin" with email: "admin@email.com" and password: "admin1"
		And Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"		

	Scenario: An Admin can access the Admin Dashboard
		Given I am logged in as "Admin"
		And I am on the User Home Page
		Then I should see "Admin"
		When I follow "Admin"
		Then I should be on the Admin Dashboard

	Scenario: A user cannot access the Admin Dashboard
		Given I am logged in as "Mario Rossi"
		And I am on the User Home Page
		Then I should not see "Admin"