Feature: Various Users see the band's page
  As a generic user / band manager / band member
  I can see the band's page
  Because I want to see band informations


Background: user "Mario Rossi" created a band named "Rossi's Band" and "Giulio Bianchi" is a band member
  Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  And Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
  And Exists user "Utente Generico" with email: "generic@email.com" and password: "123456"
  And Exists band "Rossi's Band" created by user "Mario Rossi"
  And "Giulio Bianchi" is a member of "Rossi's Band"


Scenario: Generic user visit "Rossi's Band" page
  Given I am logged in as "Utente Generico"

Scenario: "Mario Rossi" visit "Rossi's Band" page as band manager

Scenario: "Giulio Bianchi" visit "Rossi's Band" page as a band member
