Feature: Manage Roles
    In order for people to have access to features
    As a administrator (of some sort)
    I want to manage roles

    Background:
        Given I am a member in "LIM" with roles "lim_web"

    Scenario: View roles
        Given the following roles exist: "lim", "ark", "dg"
        When I go to the roles page
        Then I should see "lim"
        And I should see "ark"
        And I should see "dg"

    Scenario: Create new role
        Given I am on the roles page
        When I follow "Create role"
        And I fill in the following:
            |   Title         |   duste_g                                         |
            |   Name          |   Dustegjengen                                    |
            |   Description   |   Denne gjengen er dust.                          |
        And I press "Create role"
        Then I should be on the role page for "duste_g"
        And I should see "The role has been created."
        And I should see "duste_g"

    Scenario: Edit existing role
        Given there is a role titled "lim" and named "Layout Info Markedz00r"
        And I am on the roles page
        When I follow "Edit role"
        And I fill in the following:
            |   Name           |   Layout Info Marked                           |
        And I press "Update role"
        Then I should be on the role page for "lim"
        And I should see "Rollen er oppdatert."
        And I should see "Layout Info Marked"
        And I should not see "Layout Info Markedz00r"

    Scenario: List people with a given role
        Given there is a member with first name "Lars"
        And the member "Lars" has the role of "lim_web"
        And there is a member with first name "Ola"
        And the member "Ola" has the role of "lim_web"
        When I go to the roles page
        And I follow "lim_web"
        Then I should be on the role page for "lim_web"
        And I should see "Lars"
        And I should see "Ola"

    Scenario: Give a person a role
        Given there is a role titled "lim_web"
        Given there is a member with first name "Lars"
        And I am on the role page for "lim_web"
        And I fill in "member_id" with member information of "Lars"
        And I press "Add member"
        Then I should be on the role page for "lim_web"
        And I should see "Medlemmet er lagt til."

    Scenario: Give a person a role which they already have
        Given there is a member with first name "Lars"
        And the member "Lars" has the role of "lim_web"
        And I am on the role page for "lim_web"
        And I fill in "member_id" with member information of "Lars"
        And I press "Add member"
        Then I should be on the role page for "lim_web"
        And I should see "Medlemmet har allerede denne rollen."

    Scenario: Remove a role from a person
        Given there is a member with first name "Lars"
        And the member "Lars" has the role of "lim"
        And I am on the role page for "lim"
        And I follow "Remove member"
        Then I should be on the role page for "lim"
        And I should see "Medlemmet er slettet."
