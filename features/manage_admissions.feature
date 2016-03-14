Feature: Manage Admissions
    In order to get new members to Samfundet
    As a manager (of some sort)
    I want to manage admissions

    Background:
        Given I am a member in "LIM" with roles "lim_web"

    Scenario: Open and Closed Admissions
        Given there are open admissions titled Autumn Admission 2009, Spring Admission 2010
        And there are closed admissions titled Spring Admission 2007
        When I go to the admissions page
        Then I should see "Autumn Admission 2009"
        And I should see "Spring Admission 2010"
        And I should see "Spring Admission 2007"

    Scenario: Create a new Admission
        Given I am on the new admission page
        And I fill in "Job title" with "Special autumn admission"
        # set "Visible from" to a point in the past so that
        # the admission shows up on the admissions page
        And I fill in "Visible from" with "2000-08-18 18:00"
        And I fill in "Shown application deadline" with "2020-08-25 18:00"
        And I fill in "Actual application deadline" with "2020-08-25 22:00"
        And I fill in "Priority deadline for applicants" with "2020-08-31 23:57"
        And I fill in "Priority deadline for groups" with "2020-09-01 01:00"
        And I press "Create Admission"
        Then I should be on the admissions page
        And I should see "Special autumn admission"

#    Scenario: Navigate to create Admission
#      Given I am on the admissions page
#      And I am logged in as an user with username "admission_manager"
#      When I follow "New admission"
#      Then I should be on the new admission page

