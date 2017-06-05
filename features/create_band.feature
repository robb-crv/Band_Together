Feature: User creates a Band
  As a generic user
  I can create a band
  Because I want to start the band activities



  Background: user is logged in as "Mario Rossi" and he is in the User Home Page
		Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
		And I am logged in as "Mario Rossi"
		And I am on the User Home Page

  @javascript
  Scenario: User "Mario Rossi" creates a new band (happy way)
    When I follow "New Band"
    Then I should be on the New Band Page
    And I fill "Name" with "Jazz Band"
    And I fill "Description" with "My new band"
    And I select "Jazz" from "Musical Genre"
    And I select "Italy" from "Nation"
    And I select "Latium" from "Region"
    And I select "Rome" from "City"
    And I press "Create"
    Then I should be on the Band Page
    And I should see "The band has been created successfully."

  @javascript
    Scenario: User "Mario Rossi" tries to create a new band without band's location (sad way)
      When I follow "New Band"
      Then I should be on the New Band Page
      When I fill "Name" with "Jazz Band"
      And I fill "Description" with "My new band"
      And I select "Jazz" from "Musical Genre"
      And I press "Create"
      Then I should be on the New Band Page
      And I should see "Invalid parameters."
