Feature: Article Browsing
         In order to be up to date with my RSS sources
         As a registred user
         I want to browse articles from my RSS sources

         Background:
                Given I am a user of the site
                And I have "1" channel with name "MS Paint Adventures"
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

         @javascript
         Scenario: Star an article
                   Given I click "MS Paint Adventures" link
                   And I star the first unread article
                   When I click "Starred Items" link
                   Then I should see 1 article

         @javascript
         Scenario: Read an article
                   Given I click "MS Paint Adventures" link
                   When I click the first article
                   Then I should see 1 read article

         @javascript
         Scenario: View all items on a channel
                   Given I click "MS Paint Adventures" link
                   And I click the first article
                   And I click "MS Paint Adventures" link
                   When I click All items link within channel articles
                   Then I should see 1 read article and many unread articles

         @javascript
         Scenario: View all items on all channels
                   Given I click "MS Paint Adventures" link
                   And I click the first article
                   When I click All items link within special channels
                   Then I should see 1 read article and many unread articles