Feature: User could follow or be followed 

	As a generic user
	I can follow/unfollow other user 

	Background: user "Mario Rossi" is logged in, he's watching "Giulio Bianchi" profile  
		
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  		And I am logged in as "Mario Rossi"
  		Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
  		Given I am on the Profile Page of "Giulio Bianchi"
		
	Scenario: "Mario Rossi" start following "Giulio Bianchi"
		
		When I press 'Follow'
		Then I start to follow "Giulio Bianchi"

	Scenario: "Mario Rossi" stop following "Giulio Bianchi"
		
		When I press 'Un-Follow'
		Then I stop following "Giulio Bianchi"
