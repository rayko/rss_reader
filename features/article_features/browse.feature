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