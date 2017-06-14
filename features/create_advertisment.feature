Feature: Band Manager creates a new advertisment
  As a band manager
  I can add an advertisment giving the band type, name, max/min number of members, objective, description and location of the band
  Because I want to open the recruitment of members

  Background: user "Mario Rossi" created a band named "Band di Rossi"
    Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
    And Exists band "Band di Rossi" created by user "Mario Rossi"
    Given I am logged in as "Mario Rossi"
    When I follow "Profile"
    And I follow the link to "Band di Rossi"
    And I follow "New Advertisment"
    Then I should be on the New Advertisment Page

  Scenario: User "Mario Rossi" creates a new advertisment relative to the band "Band di Rossi" (happy way)

    When I fill in "Title" with "Cercasi chitarrista"
    And I fill in "Description" with "La Band di Rossi cerca chitarrista con passione per il rock"
    And I select "Lead Guitarist" and "Bass Guitarist" as "Musicians Needed"
    And I select as a "Term Date" 1 month from now
    And I press on "Create"
    Then I should be on the Advertisment Page of the advertisment "Cercasi chitarrista" of the band "Band di Rossi"


    Scenario: User "Mario Rossi" tries to create a new advertisment relative to the band "Band di Rossi" providing a wrong term date (sad way)

      When I fill in "Title" with "Cercasi chitarrista"
      And I fill in "Description" with "La Band di Rossi cerca chitarrista con passione per il rock"
      And I select as a "Term Date" 1 month ago
      And I press on "Create"
      Then I should be on the New Advertisment Page
      And I should see an error that tells me that the object couldn't be saved
