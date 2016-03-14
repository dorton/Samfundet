Feature: View admissions and jobs
    In order to find interesting jobs at Samfundet
    As a guest
    I want to see all the jobs

    Scenario: List all admissions
        Given there are open admissions titled "Autumn Admission 2010", "Spring Admission 2011"
        When I go to the admissions page
        Then I should see "Autumn Admission 2010"
        And I should see "Spring Admission 2011"

    Scenario: List jobs in admissions
        Given there are jobs titled "Webutvikler", "Kokk", "DJ"
        When I go to the admissions page
        Then I should see "Webutvikler"
        And I should see "Kokk"
        And I should see "DJ"

    Scenario: List all groups with jobs in the admission
        Given the groups "Layout Info Marked", "Serveringsgjengen" have listed jobs
        When I go to the admissions page
        Then I should see "Layout Info Marked" within "#groups-with-jobs"
        And I should see "Serveringsgjengen" within "#groups-with-jobs"
