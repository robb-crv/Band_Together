Feature: "Mario Rossi" reviews "Giulio Bianchi"
	
	As a Generic User 
	I can give a feedback to other users
	because I want to rate them 

	Background: user "Mario Rossi" is logged in, he's watching "Giulio Bianchi" profile  
		
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  		And I am logged in as "Mario Rossi"
  		Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
  		Given I am on the Profile Page of "Giulio Bianchi"

    @javascript
  	Scenario: User "Mario Rossi" create a review for "Giulio Bianchi"

  		When I follow the link "Review this User"
  		Then I should be on the New review Page
  		When I fill star ratings with 4 stars
  		And I fill in "description" with "descr"
  		And I press on "Send"
  		Then I should be on Giulio Bianchi profile Page