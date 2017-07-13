Feature: Invite an user to join the band 
	
	As a band member 
	I can send an invite to another user to join to the band
	because I want to allow him to join to the band

	Background: user "Mario Rossi" is logged in; he creates the band "Band di Rossi"; user "Giulio Bianchi" is watching "Band di Rossi" profile

		Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  		And Exists band "Band di Rossi" created by user "Mario Rossi"
  		And I am logged in as "Mario Rossi"
  		Given I am on the Band Page of "Band di Rossi"

	Scenario: "Mario Rossi" send invitation for 'Band di Rossi' to "Giulio Bianchi" , and he accept 

		When "Mario Rossi" press 'Invite people!'
		Then I should be on the new request page 
		And I fill "Username" with 'giuliobianchi'
		And I press "Send"
		Given I am not logged in
		And I am logged in as "Giulio Bianchi"
		And I am on the Band Page of "Band di Rossi"
		Then "Giulio Bianchi" see the pending invitation and accept it

	Scenario: "Mario Rossi" send invitation for 'Band di Rossi' to "Giulio Bianchi" , and he decline 

		Given I am on the Band Page of "Band di Rossi"
		When "Mario Rossi" press 'Invite people!'
		Then I should be on the new request page 
		And I fill "Username" with 'giuliobianchi'
		And I press "Send"
		Given I am not logged in
		And I am logged in as "Giulio Bianchi"
		And I am on the Band Page of "Band di Rossi"
		Then "Giulio Bianchi" see the pending invitation and decline it