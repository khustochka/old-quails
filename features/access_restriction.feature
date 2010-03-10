Feature: Restricted access to administration parts for external users
  # Will fail if CONFIG[:open_access] == true

  Scenario: Unauthorized user should not see Admin root

    When I go to '/admin'
    Then I should see 404 status page

  Scenario: Unauthorized user should not see Admin dashboard

    When I go to Admin dashboard
    Then I should get "401 Unauthorized" response status

  Scenario: User with invalid credentials should not see Admin dashboard

    Given logged as "admin" with password "any4passwd"
    When I go to Admin dashboard
    Then I should get "401 Unauthorized" response status

  Scenario: User with admin credentials should see Admin dashboard

    Given logged as "admin" with password "secret2pwd"
    When I go to Admin dashboard
    Then I should get "200 OK" response status

  Scenario: Unauthorized user should not see Ordines Index

    When I go to Ordines Index
    Then I should see 404 status page

  Scenario: Unauthorized user should not see Familiae Index

    When I go to Familiae Index
    Then I should see 404 status page

  Scenario: Unauthorized user should not see New Ordo page

    When I go to the new ordo page
    Then I should see 404 status page

  Scenario: Unauthorized user should not see New Familia page

    When I go to the new familia page
    Then I should see 404 status page

  Scenario: Unauthorized user should not see New Species page

    When I go to the new species page
    Then I should see 404 status page

  Scenario: Unauthorized user should not create new ordo

    When I post the following to '/admin/ordines':
      | name_la   | Noviformes  |
    Then I should see 404 status page

  Scenario: Unauthorized user should not create new familia

    When I post the following to '/admin/familiae':
      | name_la   | Novidae     |
    Then I should see 404 status page

  Scenario: Unauthorized user should not create new species

    When I post the following to '/admin/species':
      | name_la   | Novus novissimus  |
    Then I should see 404 status page