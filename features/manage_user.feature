Feature: Admin manages user information via Rails_Admin Dashboard
	As Admin
	I can manage user information 
	because I want to modify his data stored in the application

	Background: User is logged in as Admin and he is in the admin dashboard
		Given Exists admin user "Admin" with email: "admin@email.com" and password: "admin1"
		And Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		And I am logged in as "Admin"
		And I am on the User Home Page
		And I follow "Admin Dashboard"
		Then I should be on the Admin Dashboard
		And I follow "Users"
		Then I should be on the Users Index

	@javascript
	Scenario: Ban user
		When I follow "Ban this user" on user "Mario Rossi"
		Then user "Mario Rossi" should be banned 

