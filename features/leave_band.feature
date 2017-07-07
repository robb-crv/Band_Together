Feature: Band member leaves the band
As a generic user
I can leave a band that I attended
Because I am not interested in attending it anymore

Background: user "Mario Rossi" creates the band "Band di Rossi" and "Giulio Bianchi" is member of "Band di Rossi"
  Given Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
  And Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  And Exists band "Band di Rossi" created by user "Mario Rossi"
  And "Giulio Bianchi" is member of "Band di Rossi"
  And I am logged in as "Giulio Bianchi"
  Given I am on the Band Page of "Band di Rossi"


Scenario: user "Giulio Bianchi" leaves the band "Band di Rossi"
  When I press "Leave Band"
  Then I should be redirected to the band "Band di Rossi"
  And I should not be member of "Band di Rossi" anymore
