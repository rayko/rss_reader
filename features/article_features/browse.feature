Feature: Article Browsing
         In order to be up to date with my RSS sources
         As a registred user
         I want to browse articles from my RSS sources

         Background:
                Given I am a user of the site
                And I have "1" channel
                And I am on the index page


         @javascript
         Scenario: Retrive Articles List
                   When I click "MS Paint Adventures" link
                   Then page should have many unread articles

         @javascript
         Scenario: Mark all atricles as read
                   Given I click "MS Paint Adventures" link
                   When I click "Mark all as read" link
                   Then page should have no unread articles

         @wip
         @javascript
         Scenario: Star an article
                   Given I click "MS Paint Adventures" link
                   And I star the first unread article
                   When I click "Starred Items" link
                   Then I should see 1 article