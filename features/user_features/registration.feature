Feature: User Registration
         In order to access the site
         As a guest
         I want to be able to register using the registration form

         Scenario: Registration
                Given I am on the index page
                And I click the signup link
                And I fill in "User First Name" with "Lolcat"
                And I fill in "User Last Name" with "McCallister"
                And I fill in "User Username" with "lolcat"
                And I fill in "User Email" with "lolcat@example.com"
                And I fill in "User Password" with "123456789"
                And I fill in "User Password Confirmation" with "123456789"
                When I click "Submit" button
                Then page should have notice message "A message with a confirmation link has been sent"

        Scenario: Confirmation
                  Given I created an account
                  When I click the confirmation link from the email
                  Then page should have notice message "Your account was successfully confirmed"
