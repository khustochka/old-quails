Feature: Restricted access to administration parts for external users
  # Will fail if CONFIG[:open_access] == true

  Scenario: Unauthorized user should not see Admin root

    When I go to '/admin'
    Then I should see 404 status page

  Scenario: Unauthorized user should not see Admin dashboard

    When I go to Admin dashboard
    Then I should get "401 Unauthorized" response status

  Scenario: User with invalid credentials should not see Admin dashboard

    Given logged as "someuser" with password "any4passwd"
    When I go to Admin dashboard
    Then I should get "401 Unauthorized" response status

  Scenario: Unauthorized user should not see Ordines Index

    When I go to Ordines Index
    Then I should see 404 status page

  Scenario: Unauthorized user should not see Familiae Index

    When I go to Familiae Index
    Then I should see 404 status page

  Scenario: Unauthorized user should not see New Ordo page

    When I go to New Ordo page
    Then I should see 404 status page

  Scenario: Unauthorized user should not see New Familia page

    When I go to New Familia page
    Then I should see 404 status page

  Scenario: Unauthorized user should not see New Species page

    When I go to New Species page
    Then I should see 404 status page