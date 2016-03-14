Feature: Smart/adaptive login
    As a guest
    I want to login to either as a member or applicant
    In order to get access to the correct resources

    @wip
    Scenario: Open admission
        Given there are open admissions titled "Høstopptak 2011"
        When I go to the login page
        Then I should see a notice about open admissions

    Scenario: No open admissions
        Given there are closed admissions titled "Høstopptak 2011"
        When I go to the login page
        Then I should not see a notice about open admissions
