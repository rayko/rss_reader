Feature: Channel Administration
         In order to read news
         As a registred user
         I want to manage channels

         Scenario: Channel Creation from Channel Manager
                   Given I am a user of the site
                   And I click "Manage Channels" link
                   And I click "Add Channel" link from channel manager
                   And I fill in Channel Url with "http://mspaintadventures.com/rss/rss.xml"
                   When I click Add button from channel manager
                   Then page should have notice message "Channel created"
                   And page should have "MS Paint Adventures"


         Scenario: Channel Title edit
                   Given I am a user of the site
                   And I have "1" channel
                   And I am on manage channels section
                   And I click "Edit" link
                   And I fill in "Channel Name" with "My Channel"
                   When I click "Save" button
                   Then page should have notice message "Channel was successfully updated"
                   And page should have "My Channel"

         @javascript
         Scenario: Channel Deletion
                   Given I am a user of the site
                   And I have "1" channel
                   And I am on manage channels section
                   And I click "Destroy" link
                   When I confirm dialog
                   Then page should have "No channels"

         @wip
         Scenario: Channel Show
                   Given I am a user of the site
                   And I have "1" channel
                   And I am on manage channels section
                   When I click "Show" link
                   Then page should have my channel information