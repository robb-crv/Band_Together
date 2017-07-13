Feature: Band manager removes one of the members of his Band
As Band manager
I can remove one of the band's member from the band
Because I want to free a spot


Scenario: "Mario Rossi" removes "Giulio Bianchi" from the members of "Band di Rossi"
	Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
	Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  	And Exists band "Band di Rossi" created by user "Mario Rossi"
  	And "Giulio Bianchi" is member of "Band di Rossi"
  	And I am logged in as "Mario Rossi"
  	And I am on the Band Page of "Band di Rossi"
  	When I press on the "X" button near the member "Giulio Bianchi"
  	Then I should be redirected to the band "Band di Rossi"
  	And "Giulio Bianchi" should not be member of "Band di Rossi" anymore