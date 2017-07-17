Feature: User searches for informations about other users, advertisments and bands

	As a user
	I want to search for other users, advertisments and bands
 	Because I want to see informations about them

 	Background: user "Mario Rossi" exists on the db; he creates the band "Band di Rossi"; he creates the advertisment "Adv"; user "Giulio Bianchi" is logged in

		Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  		And Exists band "Band di Rossi" created by user "Mario Rossi"
  		And Exists advertisment "Adv" for "Band di Rossi" 
  		And I am logged in as "Giulio Bianchi"
  		And I am on the User Home Page

  	@javascript
  	Scenario: "Giulio Bianchi" types "Mario" on the search bar
  		When I fill the search bar with "Mario"
  		Then I should be on the Search Index Page
  		And I should see "Adv" as a result
  		When I follow Users
  		Then I should see "Mario Rossi" as a result
  		When I follow Bands
  		Then I should see "Band di Rossi" as a result

  	


