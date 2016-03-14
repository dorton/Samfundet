Feature: Applicant applying for jobs
    In order to get accepted into a group
    As a applicant
    I want to apply for jobs

    Background:
        Given I am logged in as an applicant with email "applicant@example.com"

    Scenario: Apply for jobs
        Given There are jobs titled Webutvikler
        And I am on the admissions page
        When I follow "Webutvikler"
        And I fill in the following:
            | motivation | I like programming |
        And I press "Apply for this job"
        Then I should be on applicant@example.com's applications page
        And I should see "Webutvikler"

    Scenario: Only Apply Once
        Given I have applied for jobs titled Webutvikler
        And I am on the admissions page
        When I follow "Webutvikler"
        Then I should see a button with value "Update application"

        #TODO: Edit job application motivation
