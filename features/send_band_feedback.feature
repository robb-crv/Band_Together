Feature: User reviews a band

	As a Generic User
	I can give a feedback to bands
	because I want to rate them

	Background: user "Mario Rossi" has created "Band di Rossi", "Giulio Bianchi" is a member of "Band di Rossi"
    Given Exists user "Mario Rossi" with email: "mariorossi@gmail.com" and password: "123456"
    And Exists user "Giulio Bianchi" with email: "giuliobianchi@gmail.com" and password: "123456"
    And Exists band "Band di Rossi" created by user "Mario Rossi"
    And "Giulio Bianchi" is member of "Band di Rossi"
    And I am logged in as "Giulio Bianchi"
    Given I am on the Band Page of "Band di Rossi"

    @javascript
  	Scenario: User "Mario Rossi" create a review for "Band di Rossi"

  		When I follow the link "Review this Band"
  		Then I should be on the New review Page
  		When I fill star ratings with 4 stars
  		And I fill in "description" with "descr"
  		And I press on "Send"
  		Then I should be on the Band Page of "Band di Rossi"
      And I should see a feedback that confirm the changes
