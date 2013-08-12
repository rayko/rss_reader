Feature: User Profile Administration
         In order to update my profile
         As a registred and confirmed user
         I want to edit my profile

         Scenario: View Profile
                   Given I created and confirmed my account
                   And I am logged in
                   And I am on the index page
                   When I click "Edit Profile" link
                   Then I should see my information