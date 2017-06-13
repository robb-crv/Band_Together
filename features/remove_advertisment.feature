Feature: Band Manager removes an advertisment from the relative band
  As a band manager
  I can remove an advertisment
  Because I want to close the recruitment of members


    Scenario: User "Mario Rossi" removes the advertisment "Cercasi chitarrista" relative to the band "Band di Rossi"
      Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
      And Exists band "Band di Rossi" created by user "Mario Rossi"
      And Exists advertisment "Cercasi chitarrista" for the band "Band di Rossi"
      And I am logged in as "Mario Rossi"
      When I follow "Profile"
      And I follow the link to "Band di Rossi"
      Then I should be on the Band Page of "Band di Rossi"
      And I should see "Cercasi chitarrista" in the "Active Advertisments" table
      When I press "delete" for the advertisment "Cercasi chitarrista"
      Then I should not see "Cercasi chitarrista" in the "Active Advertisments" table anymore
