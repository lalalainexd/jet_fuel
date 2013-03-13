Feature: Sort URLs
  As an an anonymous visitor
  I want to see the URLS sorted by popularity
  And date added

  Background:
    Given a shortened url for http://www.facebook.com
    And a shortened url for http://www.jumpstartlab.com
    And a shortened url for http://www.google.com
    And http://www.facebook.com has 3 visits
    And http://www.jumpstartlab.com has 4 visits
    And http://www.google.com has 2 visits

  Scenario: I want to see the URLS sorted by number of visits
    Given that I am an anonymous user
    When I visit the site
    Then I expect to see the URLs sorted by popularity

