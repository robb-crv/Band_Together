Feature: User Sends message to others
  As a generic user
  I can send messages to other application users
  Because I want to communicate with them




  Background: user is logged in as "Mario Rossi" and he is in the User Home Page
    Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
    And Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"




  Scenario: "Mario Rossi" sends a message to "Giulio Bianchi"
    Given I am logged in as "Mario Rossi"
    And I am on the User Home Page
    When I go to the Messages Page
    And I follow "New Conversation"
    And I fill "To" with "giuliobianchi@gmail.com"
    And I fill "Subject" with "Test Subject"
    And I fill "Body" with "Hi Giulio, are you OK?"
    And I press "Send Message"
    Then I should see in the Conversations Table the conversation "Test Subject"

    Given I am not logged in
    And I am logged in as "Giulio Bianchi"
    And I am on the User Home Page
    When I go to the Messages Page
    Then I should see in the Conversations Table the conversation "Test Subject"
