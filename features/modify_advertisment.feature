Feature: Band Manager modifies Advertisment's informations
  As a band manager
  I can modify advertisment parameters
  Because I want to update avertisment data

  Background: user "Mario Rossi" created a band named "Band di Rossi"
    Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
    And Exists band "Band di Rossi" created by user "Mario Rossi"
    And Exists advertisment "Cercasi chitarrista" for the band "Band di Rossi"
    And I am logged in as "Mario Rossi"
    When I follow "Profile"
    And I follow the link to "Band di Rossi"
    Then I should be on the Band Page
    And I should see "Cercasi chitarrista" in the "Active Advertisments" table
    When I press "edit" for the advertisment "Cercasi chitarrista"
    Then I should be on the Edit Advertisment Page

Scenario: User "Mario Rossi" change the term date of the advertisment "Cercasi chitarrista" relative to the band "Band di Rossi"   (happy way)
    When I select as a "Term Date" 1 month from now
    And I follow "Update"
    Then I should be on the Advertisment Page of the advertisment "Cercasi chitarrista" of the band "Band di Rossi"
    And I should see a feedback that confirm the changes


Scenario: User "Mario Rossi" tries to change the term date of the advertisment "Cercasi chitarrista" relative to the band "Band di Rossi" (sad way)
    And I select as a "Term Date" 1 month ago
    And I follow "Update"
    Then I should be on the Edit Advertisment Page
    And I should see an error that tells me that the object couldn't be saved
