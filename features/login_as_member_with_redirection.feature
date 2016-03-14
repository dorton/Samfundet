Feature: Login as a member with redirection
    In order to access internal systemsGiven there is a member with email "valid@member.com" and password "password"
    As a registered member
    I want to log in

    Background:
        Given there is a member with first name "John", email "valid@user.com" and password "password"
        And the member "John" has the role of "lim_web"
        And there is a group named "LIM"

    Scenario: Successfull login
        Given I am on the edit group page for "LIM"
        And I fill in "valid@user.com" for "member_login_id"
        And I fill in "password" for "member_password"
        And I press "member_login"
        Then I should be on the edit group page for "LIM"
        And I should be logged in

    Scenario: Unsuccessfull at first
        Given I am on the edit group page for "LIM"
        And I fill in "valid@user.com" for "member_login_id"
        And I fill in "this aint my password, dawg" for "member_password"
        And I press "member_login"
        Then I should be on the member login page
        When I fill in "valid@user.com" for "member_login_id"
        And I fill in "password" for "member_password"
        And I press "member_login"
        Then I should be on the edit group page for "LIM"
        And I should be logged in
