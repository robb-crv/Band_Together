Feature: Band Manager modify band's informations
  As a band manager
  I can modify the band's informations
  Because I want to update band informations


  Background: user "Mario Rossi" created a band named "Band di Rossi"
      Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
      And Exists band "Band di Rossi" created by user "Mario Rossi"
      Given I am logged in as "Mario Rossi"
      When I visit my Profile Page
      Then I should see "Band di Rossi" in the "Created Bands" table
      When I press "edit" for the band "Band di Rossi"
      Then I should be on the Edit Band Page of "Band di Rossi"

@javascript
  Scenario:  User "Mario Rossi" change the description and the location of the band "Band di Rossi"
    When I fill "Description" with "New Description"
    And I select "Italy" from "Nation"
    And I select "Latium" from "Region"
    And I select "Rome" from "City"
    And I follow "Update"
    Then I should be on the Band Page of "Band di Rossi"
    And I should see "New Description" for the field "Description"
    And I should see "Rome" for the field "City"
    And I should see a feedback that confirm the changes
