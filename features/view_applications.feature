Feature: View applications
    In order to get an overview of the applicants
    As a group leader or a section manager
    I want to be able to view applications

    Background:
        Given I am a member in "LIM" with roles "lim_opptaksansvarlig"

    Scenario: Created jobs should show up in group applications page
        Given there are closed admissions titled Høstopptak
        And my group, "LIM", has the following jobs: "Webutvikler", "Layout", "Info"
        When I am on the group interviews page for "LIM" in "Høstopptak"
        Then I should see "Høstopptak"
        And I should see "Webutvikler"
        And I should see "Layout"
        And I should see "Info"
