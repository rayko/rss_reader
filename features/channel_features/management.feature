Feature: Channel Administration
         In order to read news
         As a registred user
         I want to manage channels

         Scenario: Channel Creation
                   Given I am a user of the site
                   And I click "Channels" link
                   And I click "Add Channel" link
                   And I fill in "Channel Url" with "http://my_site.com/my_channel"
                   When I click "Save" button
                   Then page should have notice message "Channel created"
                   And page should have "MS Paint Adventures"