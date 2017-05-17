Feature: Generic user visits the Home Page
  As a generic user
  I can see contact, about and description of the app
  because I want to visit the page of the app
  
  
  Scenario: See description of the application
    Given I am on the Home Page
    Then I should see "You'll never play alone"
  
  Scenario: See Contact Page 
    Given I am on the Home Page
    When I follow "Contact"
    Then I should see Contact Page
    
    Scenario: See About Page
    Given I am on the Home Page
    When I follow "About"
    Then I should see the About Page
  
  
  