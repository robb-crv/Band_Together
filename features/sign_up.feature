Feature: Generic User Signs up on the application
  As a generic user	
  I can create an account (also with google or Facebook)
  Because I want to register an account
  
  Scenario:
    
    Given I am on the Home Page
    When I follow "Sign Up"
    Then I should be on the Sign Up Page
    When I fill in "Name" with "Mario"
    And I fill in "Surname" with "Rossi"
    And I fill in "Username" with "rossimario95"
    And I fill in "Email" with "mariorossi@gmail.com"
    And I fill in "Birth Date" with "22-02-1955"
    And I select "Male" from "Sex"
    And I select "Italy" from "Nation"
    And I select "Lazio" from "Region"
    And I press "Submit"
    Then I should be on the User Home Page