Feature: Manage ordines
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new ordo
    Given logged as administrator
    When I go to the new ordo page
    When I fill in the following:
      | Name la | Sphenisciformes2   |
      | Name ru | Пингвинообразные  |
      | Name uk | Пінгвіноподібні   |
    And I press "Create"
    Then I should see "Sphenisciformes"

#  Scenario: Delete ordo
#    Given the following ordines:
#      |name_la|
#      |name_la 1|
#      |name_la 2|
#      |name_la 3|
#      |name_la 4|
#    When I delete the 3rd ordo
#    Then I should see the following ordines:
#      |Name la|
#      |name_la 1|
#      |name_la 2|
#      |name_la 4|
