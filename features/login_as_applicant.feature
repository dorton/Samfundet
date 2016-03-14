Feature: Login as an applicant
    In order to apply and manage jobs
    As a registered or unregistered applicant
    I want to log in

    Background:
        Given there is an applicant with email "valid@applicant.com" and password "password"
        And there are open admissions titled "Høstopptak 2011"

    Scenario: Direct successful login
        Given I am on the login page
        When I log in as an applicant with email "valid@applicant.com" and password "password"
        Then I should be on the admissions page
        And I should be logged in

    Scenario: Direct unsuccessful login
        Given I am on the login page
        When I log in as an applicant with email "invalid@applicant.com" and password "invalid password"
        Then I should be on the applicant login page
        And I should not be logged in
        And the applicant email field should contain "invalid@applicant.com"
