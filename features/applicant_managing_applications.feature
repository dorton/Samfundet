Feature: Applicant managing jobs
    In order to review, prioritize and withdraw job application
    As a applicant
    I want to access my job applications

    Background:
        Given I am logged in as an applicant with email "applicant@example.com"

    Scenario: View Application
        Given I have applied for jobs titled Webutvikler
        And I am on applicant@example.com's applications page
        When I follow "Webutvikler"
        Then I should see "Webutvikler"

    Scenario: Delete Application
        Given I have applied for jobs titled Webutvikler, Webdesigner
        And I am on applicant@example.com's applications page
        When I follow "Webutvikler"
        And I follow "Withdraw application"
        Then I should be on applicant@example.com's applications page
        And I should see "Webdesigner"
        But I should not see "Webutvikler"

    Scenario: Update Application
        Given I have applied for jobs titled Webutvikler
        And I am on applicant@example.com's applications page
        When I follow "Webutvikler"
        And I fill in the following:
            | motivation | This is an update! |
        And I press "Update application"
        Then I should be on applicant@example.com's applications page
        When I follow "Webutvikler"
        Then I should see "This is an update!"
