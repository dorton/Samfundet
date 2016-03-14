Feature: Member registering as an applicant
    In order to apply for new jobs
    As an existing member
    I want to register an an applicant

    Background:
        Given I am logged in as a member with email "member@samfundet.no" and password "password"

    Scenario: Logged in as member and registering as applicant
        Given I am on the admissions page
        And I follow "Register as an applicant"
        When I fill in the following:
            | First name                      | John                |
            | Surname                         | Doe                 |
            | Phone number                    | 12345678            |
            | Email                           | member@samfundet.no |
            | applicant_password              | secret              |
            | applicant_password_confirmation | secret              |
        And I press "Register me"
        Then I should be on the admissions page
        And I should be logged in as an applicant with email "member@samfundet.no"
