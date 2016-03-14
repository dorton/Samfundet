Feature: Applicant prioritizing jobs
    In order to choose the best looking job
    As a applicant
    I want to prioritize my job applications

    Scenario: Prioritize applications
        Given I am logged in as an applicant with email "user@example.com"
        And I have applied for jobs titled "Webutvikler", "Webdesigner"
        And I am on user@example.com's applications page
        Then I should see the following:
            | Webutvikler |
            | Webdesigner |
        When I press "Up" in the last row
        Then I should be on user@example.com's applications page
        And I should see the following:
            | Webdesigner |
            | Webutvikler |
        When I press "Down" in the first row
        Then I should be on user@example.com's applications page
        And I should see the following:
            | Webutvikler |
            | Webdesigner |
