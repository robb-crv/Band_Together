Feature: User could join a Band 

	As a generic user
	I can join a Band 
	because I want to be a band member
      
	Background: user "Mario Rossi" is logged in; he creates the band "Band di Rossi"; user "Giulio Bianchi" is watching "Band di Rossi" profile  
		
		Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  		And Exists band "Band di Rossi" created by user "Mario Rossi"	
  		And I am logged in as "Giulio Bianchi"
  		Given I am on the Band Page of "Band di Rossi"
		
	Scenario: "Mario Rossi" send join request for 'Band di Rossi'
		
		When "Mario Rossi" press 'Join!'
		Then the request has been sent and user is still on the page 'Band di Rossi'
				

	