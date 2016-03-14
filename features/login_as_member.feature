Feature: Login as a member
    In order to access internal systems
    As a registered member
    I want to log in

    Background:
        Given there is a member with email "valid@member.com" and password "password"

    Scenario: Go to the login page
        Given I am on the home page
        When I follow "Log in"
        Then I should be on the login page

    Scenario: Direct successful login
        Given I am on the login page
        When I fill in "valid@member.com" for "member_login_id"
        And I fill in "password" for "member_password"
        And I press "member_login"
        Then I should be on the home page
        And I should be logged in

    Scenario: Direct unsuccessful login
        Given I am on the login page
        When I fill in "invalid@member.com" for "member_login_id"
        And I fill in "invalid password" for "member_password"
        And I press "member_login"
        Then I should be on the member login page
        And I should not be logged in
        And the "member_login_id" field should contain "invalid@member.com"
