Feature: Band Manager modifies Advertisment's informations
  As a band manager
  I can modify a band event
  Because I want to update event information


  Background: user "Mario Rossi" created a band named "Band di Rossi" and a relative activity in the band
    Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
    And Exists band "Band di Rossi" created by user "Mario Rossi"
    And Exists activity "Sala Prove" for the band "Band di Rossi"
    And I am logged in as "Mario Rossi"
    When I follow "Profile"
    And I follow the link to "Band di Rossi"
    Then I should be on the Band Page of "Band di Rossi"
    And I should see "Sala Prove" in the "Band Activities" table
    When I follow the link to the "Sala Prove" activity
    And I follow "Edit"
    Then I should be on the Edit Activity Page

Scenario: User "Mario Rossi" changes the duration of the activity "Sala Prove" relative to the band "Band di Rossi"   (happy way)
    When I select as a "Duration" 1 hour
    And I follow "Update"
    Then I should be on the Activity Page of the activity "Sala Prove" of the band "Band di Rossi"
    And I should see a feedback that confirm the changes


Scenario: User "Mario Rossi" changes the duration of the activity "Sala Prove" relative to the band "Band di Rossi" (sad way)
    When I select as "Duration" 0 hour
    And I follow "Update"
    Then I should be on the Edit Activity Page
    And I should see an error that tells me that the object couldn't be saved
