Feature: Manage Groups
  In order to restrict access
  As a regular user
  I want to not be able to manage groups

  Scenario: Create new group
    Given I am on the new group page
    Then I should be required to log in

  Scenario: Edit existing group
    Given there is a group named "LIM"
    And I am on the edit group page for "LIM"
    Then I should be required to log in