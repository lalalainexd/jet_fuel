Feature: Redirect to original URL

  @redirect
  Scenario: Redirect to original URL
    Given I have a shortened URL from the service
    When I follow the shortened URL
    Then I expect to be redirected to the original URL


