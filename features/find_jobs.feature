Feature: Guest looking for jobs
    In order to find a job to apply for
    As a guest or applicant
    I want to have a list of all jobs

    Scenario: Find a job to apply for
        Given there are jobs titled Chef
        And I am on the home page
        When I follow "Admissions"
        And I follow "Chef"
        Then I should be on the job page for "Chef"

    Scenario: Find jobs in the same group
        Given there are jobs "Webutvikler", "Stunter" for an admission "Høstopptak 2010" for the group "Layout Info Marked"
        And I am on the admissions page
        When I follow "Webutvikler"
        Then I should see "Stunter"

    Scenario: Find similar jobs
        Given there is a job titled "Systemutvikler" in the group "Under Dusken" tagged "utvikling"
        And there is a job titled "Webutvikler" in the group "Layout Info Marked" tagged "utvikling web"
        And I am on the admissions page
        When I follow "Systemutvikler"
        Then I should see "Webutvikler"

    Scenario: Show officer status
        Given I am not logged in
        And There are jobs titled "Webutvikler"
        And "Webutvikler" is an officer position
        When I am on the admissions page
        And I follow "Webutvikler"
        Then I should see "Funksjonær"
