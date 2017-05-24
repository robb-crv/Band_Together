Feature: Generic User Signs up on the application
  As a generic user
  I can create an account
  Because I want to register an account

  @javascript
  Scenario: Generic User signs up
    Given I am on the Home Page
    When I follow "Sign Up"
    Then I should be on the Sign Up Page
    When I fill in "Username" with "rossimario95"
    And I fill in "Email" with "mariorossi@gmail.com"
    And I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "123456"
    And I fill in "First name" with "Mario"
    And I fill in "Last name" with "Rossi"
    And I select "Male" from "Gender"
    And I fill in "Birth date" with "22-02-1955"
    And I select "Italy" from "nation"
    And I select "Latium" from "region"
    And I select "Drummer" from "Instrument played"
    And I select "Rock" from "Favourite musical genre"
    And I press "Submit"
    Then I should be on the Home Page
