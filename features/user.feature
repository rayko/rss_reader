Feature: User Registration
         In order to access the site
         A guest
         Should be able to register using the registration form

         Scenario:
                Given I am on the index page
                And I click the signup link
                And I fill in "First Name" with "Lolcat"
                And I fill in "Last Name" with "McCallister"
                And I fill in "Login" with "lolcat"
                And I fill in "Email" with "lolcat@example.com"
                And I fill in "Password" with "123456789"
                And I fill in "Password Confirmation" with "123456789"
                When I press "Submit"
                Then page should have notice message "A message with a confirmation link has been sent"
