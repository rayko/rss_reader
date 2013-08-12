Feature: User Registration
         In order to access the site
         As a guest
         I want to be able to register using the registration form

         Scenario: Registration
                Given I am on the index page
                And I click the signup link
                And I fill in "First Name" with "Lolcat"
                And I fill in "Last Name" with "McCallister"
                And I fill in "Username" with "lolcat"
                And I fill in "Email" with "lolcat@example.com"
                And I fill in "Password" with "123456789"
                And I fill in "Password Confirmation" with "123456789"
                When I press "Submit"
                Then page should have notice message "A message with a confirmation link has been sent"

        Scenario: Confirmation
                  Given I created an account
                  When I click the confirmation link from the email
                  Then page should have notice message "Your account was successfully confirmed"

        Scenario: Login with email
                  Given I created and confirmed my account
                  And I am on the index page
                  And I click "Login" link
                  And I fill in "Login" with my email
                  And I fill in "Password" with my password
                  When I click "Sign in" button
                  Then page should have notice message "Signed in successfully"
                  And I should see a "Logout" link
                  And I should see a "Edit Profile" link

        Scenario: Login with login
                  Given I created and confirmed my account
                  And I am on the index page
                  And I click "Login" link
                  And I fill in "Login" with my login name
                  And I fill in "Password" with my password
                  When I click "Sign in" button
                  Then page should have notice message "Signed in successfully"
                  And I should see a "Logout" link
                  And I should see a "Edit Profile" link