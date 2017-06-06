Feature: User visit the band's page
  As a generic user / band manager / band member
  I can visit the band's page
  Because I want to see band informations


Background: user "Mario Rossi" created a band named "Band di Rossi" and "Giulio Bianchi" is a band member
  Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  And Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
  And Exists user "Utente Generico" with email: "generic@email.com" and password: "123456"
  And Exists band "Band di Rossi" created by user "Mario Rossi"
  And "Giulio Bianchi" is a member of "Band di Rossi"


Scenario: Generic user visit "Band di Rossi" page
  Given I am logged in as "Utente Generico"
  When I search for the band "Band di Rossi"
  And I follow the link to "Band di Rossi"
  Then I should see the "Join Band" link

Scenario: "Mario Rossi" visit "Rossi's Band" page (as band manager)
  Given I am logged in as "Mario Rossi"
  When I follow "Profile"
  Then I should see "Band di Rossi" in the "Created Bands" table
  When I follow the link to "Band di Rossi"
  Then I should see the "Edit Band Informations" link

Scenario: "Giulio Bianchi" visit "Band di Rossi" page (as a band member)
  Given I am logged in as "Giulio Bianchi"
  When I follow "Profile"
  Then I should see "Band di Rossi" in the "Joined Bands" table
  And I follow the link to "Band di Rossi"
  Then I should see the "Leave Band" link
