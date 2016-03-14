Feature: Manage Jobs
    In order to get many applicants for my group.
    As a admission responsible for my group.
    I want to add jobs to an upcoming admission.

    Background:
        Given there is a group named "LIM"
        And I am a member in "LIM" with roles "lim_gjengsjef"
        And we reload authorization settings

    Scenario: View jobs for an upcoming admission.
        Given there are jobs "Stønter", "Webutvikler" for an admission "Autumn Admission 2010" for the group "LIM"
        When I go to the job page for "LIM" in "Autumn Admission 2010"
        Then I should see "Stønter"
        And I should see "Webutvikler"

    Scenario: Create new job
        Given there are open admissions titled Autumn Admission 2010
        And there is a group named "LIM"
        And I am on the job page for "LIM" in "Autumn Admission 2010"
        When I follow "Create new job"
        And I fill in the following:
            |   Title (Norsk)             |   Sanger                                          |
            |   Short description (Norsk) |   Liker du å synge?                               |
            |   Description (Norsk)       |   Har du alltid drømt om å synge? Bli med nå!!!11 |
        And I check "‘Funksjonær’ position?"
        And I press "Create Job"
        Then I should be on the job page for "LIM" in "Autumn Admission 2010"
        And I should see "Job created."
        And I should see "Sanger"

    Scenario: Edit existing job
        Given there are jobs "Webutvikler" for an admission "Autumn Admission 2010" for the group "LIM"
        And I am on the job page for "LIM" in "Autumn Admission 2010"
        When I follow "Edit job"
        And I fill in the following:
            | Title (Norsk) | Webn00b |
        And I press "Update Job"
        Then I should be on the job page for "LIM" in "Autumn Admission 2010"
        And I should see "Job updated."
        And I should see "Webn00b"
        And I should not see "Webutvikler"

    Scenario: Delete existing job
        Given there are jobs "Webutvikler" for an admission "Autumn Admission 2010" for the group "LIM"
        And I am on the job page for "LIM" in "Autumn Admission 2010"
        When I follow "Delete job"
        Then I should be on the job page for "LIM" in "Autumn Admission 2010"
        And I should see "Job deleted."
        And I should not see "Webutvikler"

    Scenario: Tag similar jobs
        Given there are jobs "Stønter", "Webutvikler" for an admission "Autumn Admission 2010" for the group "LIM"
        And the job "Stønter" has tags "awesome", "crazy"
        And I am on the edit job page for "Webutvikler"
        And I fill in the following:
            | Tags | awesome, hackers |
        And I press "Update Job"
        And I am on the job page for "Stønter"
        Then I should see "Webutvikler"
