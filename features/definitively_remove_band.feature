Feature: Band manager removes band
As a band manager
I can remove a band defeinitively from the system
because the band activities have ended or it's not of my interest anymore


Background: user "Mario Rossi" creates the band "Band di Rossi"
  And Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  And Exists band "Band di Rossi" created by user "Mario Rossi"
  And I am logged in as "Mario Rossi"
  Given I am on the Band Page of "Band di Rossi"


Scenario: user "Mario Rossi" removes the band "Band di Rossi"
  When I press "Delete Band"
  Then I should be on the User Profile Page
  And it should not exists band called "Band di Rossi" anymore
