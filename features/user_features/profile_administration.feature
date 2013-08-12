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

         Scenario: Edit non authentication information
                   Given I created and confirmed my account
                   And I am logged in
                   And I am on the index page
                   And I click "Edit Profile" link
                   And I fill in "User First Name" with "David"
                   And I fill in "User Last Name" with "Peterson"
                   And I fill in "User Current Password" with "123456789"
                   When I press "Save"
                   Then page should have notice message "You updated your account successfully"
                   And I should see "David" as "First Name" on my profile
                   And I should see "Peterson" as "Last Name" on my profile