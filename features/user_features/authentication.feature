Feature: User Authentication
        In order to access the site
        As a registred and confirmed user
        I want to authenticate with my data

        Scenario: Login with email
                  Given I created and confirmed my account
                  And I am on the index page
                  And I click "Login" link
                  And I fill in "User Login" with my email
                  And I fill in "User Password" with my password
                  When I click "Sign in" button
                  Then page should have notice message "Signed in successfully"
                  And I should see a "Logout" link
                  And I should see a "Edit Profile" link

        Scenario: Login with username
                  Given I created and confirmed my account
                  And I am on the index page
                  And I click "Login" link
                  And I fill in "User Login" with my login name
                  And I fill in "User Password" with my password
                  When I click "Sign in" button
                  Then page should have notice message "Signed in successfully"
                  And I should see a "Logout" link
                  And I should see a "Edit Profile" link

        Scenario: Logout
                  Given I created and confirmed my account
                  And I am logged in
                  And I am on the index page
                  When I click "Logout" link
                  Then page should have notice message "Signed out successfully"
                  And I should see a "Login" link
                  And I should see a "Sign Up" link
