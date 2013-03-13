Feature: Redirect to original URL

  @redirect
  Scenario: Redirect to original URL
    When I follow the shortened URL
    Then I expect to be redirected to the original URL


