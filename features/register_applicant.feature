Feature: Applicant registering
    In order to apply for jobs
    As a guest
    I want to register as an applicant

    Scenario: Go to applicant registration form
        Given I am on the home page
        And I follow "Admissions"
        When I follow "Register as an applicant"
        Then I should be on the new applicant page

    Scenario: Register
        Given I am on the new applicant page
        When I fill in the following:
            | First name                      | John                |
            | Surname                         | Doe                 |
            | Phone number                    | 12345678            |
            | Email                           | johndoe@example.org |
            | applicant_password              | secret              |
            | applicant_password_confirmation | secret              |
        And I press "Register me"
        Then I should be on the admissions page

    Scenario: Invalid password
        Given I am on the new applicant page
        When I fill in the following:
            | First name                      | John                |
            | Surname                         | Doe                 |
            | Phone number                    | 12345678            |
            | Email                           | johndoe@example.org |
            | applicant_password              | se                  |
            | applicant_password_confirmation | secrett             |
        And I press "Register me"
        Then I should see an error message
