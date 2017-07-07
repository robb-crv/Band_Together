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
		
	Scenario: "Giulio Bianchi" send join request for 'Band di Rossi' and Mario Rossi accept the request
			
  		Given I am on the Band Page of "Band di Rossi"

		When "Giulio Bianchi" press 'Join!'
		Then the request has been sent and user is still on the page 'Band di Rossi'
		
		Given I am not logged in
		And I am logged in as "Mario Rossi"
		Given I am on the Band Page of "Band di Rossi"
		Then "Mario Rossi" see the pending request and accept it


	Scenario: "Giulio Bianchi" send join request for 'Band di Rossi' and Mario Rossi decline the request

  		Given I am on the Band Page of "Band di Rossi"

		When "Giulio Bianchi" press 'Join!'
		Then the request has been sent and user is still on the page 'Band di Rossi'
		
		Given I am not logged in
		And I am logged in as "Mario Rossi"
		Given I am on the Band Page of "Band di Rossi"
		Then "Mario Rossi" see the pending request and decline it