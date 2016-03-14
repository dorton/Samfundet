Feature: Manage Groups
  In order to obtain information about groups
  As a regular visitor
  I want to browse groups

  Background:
    Given the following groups exist: "LIM", "TSS", "Sangern"

  Scenario: View groups
    When I go to the groups page
    Then I should see "LIM"
    And I should see "TSS"
    And I should see "Sangern"
