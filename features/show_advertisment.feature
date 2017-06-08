Feature: User visit the advertisment's page
  As a generic user
  I can see advertisment informations
  Because I want to evaluate to join the band



Scenario: User "Utente Generico" visits "Cercasi chitarrista" relative to the band "Band di Rossi"
  Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
  And Exists user "Utente Generico" with email: "generic@email.com" and password: "123456"
  And Exists band "Band di Rossi" created by user "Mario Rossi"
  And Exists advertisment "Cercasi chitarrista" for the band "Band di Rossi"
  And I am logged in as "Utente Generico"
  When I visit the page of the band "Band di Rossi"
  And I should see "Cercasi chitarrista" in the "Active Advertisments" table
  When I follow the link to "Cercasi chitarrista"
  Then I should be on the Advertisment Page of the advertisment "Cercasi chitarrista" of the band "Band di Rossi"
