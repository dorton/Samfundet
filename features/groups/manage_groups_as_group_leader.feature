Feature: Manage Groups
  In order to to get applicants
  As a group responsible
  I want to manage my group and only mine
  
  Background:
    Given there is a group named "MG"
    And I am a member in "MG" with roles "mg_gjengsjef"
    And we reload authorization settings
  
  Scenario: Create new group
    Given I am on the new group page
    Then I should be required to log in

  Scenario: Edit existing group that is mine
    And I am on the groups page
    When I follow "Redigér gjeng"
    And I fill in the following:
      |   Name           |   MGz00r                                          |
    And I press "Update Group"
    Then I should be on the groups page
    And I should see "Gjengen er oppdatert."
    And I should see "MGz00r"

  Scenario: Edit existing group that is not mine
    Given there is a group named "NOT MINE"
    And I am on the edit group page for "NOT MINE"
    Then I should be required to log in
