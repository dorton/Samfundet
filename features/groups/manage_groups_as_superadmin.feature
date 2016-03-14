Feature: Manage Groups
  In order to to get applicants
  As a superadmin
  I want to manage groups

  Background:
    Given I am a member in "LIM" with roles "lim_web"

  Scenario: Create new group
    Given I am on the groups page
    And there is a group type named "Drift"
    When I follow "Opprett gjeng"
    And I fill in the following:
      |   Name            |   Layout Info Marked                              |
      |   Abbreviation    |   LIM                                             |
      |   Website         |   http://lim.samfundet.no                         |
    And I select "Drift" from "Group"
    And I press "Create Group"
    Then I should be on the groups page
    And I should see "Gjengen er opprettet."
    And I should see "LIM"

  Scenario: Edit existing group
    Given there is a group named "LIMz000r"
    And I am on the groups page
    When I follow "Redigér gjeng"
    And I fill in the following:
      |   Name           |   LIM                                          |
    And I press "Update Group"
    Then I should be on the groups page
    And I should see "Gjengen er oppdatert."
    And I should see "LIM"
    And I should not see "LIMz000r"
