Feature: URLS are sorted by Popularity and when they were added

  @show_sorted_urls
  Scenario: URLS are sorted by Popularity and when they were added
    Given that I am an anonymous user of the system
    When I visit the site
    Then I expect to see URLs sorted by popularity
    And I expect to see URLs sorted by how recently they were added
