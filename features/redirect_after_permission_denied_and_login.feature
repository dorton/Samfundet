Feature: Redirect to the page you were on before being asked to log in
    In order to have a pleasant user experience
    As a registered member or applicant
    I want to be redirected to the page I tried to access before being asked to log in

    Background:
        Given there are open admissions titled Autumn Admission 2010
        And there is an applicant with email "applicant@example.com" and password "password"
        And there is a member with email "member@example.com" and password "password"

    Scenario: An applicant should be required to log in to view certain pages
        Given I am not logged in
        When I go to applicant@example.com's applications page
        Then I should be required to log in

    Scenario: After logging in, an applicant should be redirected to the correct page
        Given I am not logged in
        When I go to applicant@example.com's applications page
        And I log in as an applicant with email "applicant@example.com" and password "password"
        Then I should be on applicant@example.com's applications page

    Scenario: A member should be required to log in to view certain pages
        Given I am not logged in
        When I go to the members control panel page
        Then I should be required to log in

    Scenario: After logging in, a member should be redirected to the correct page
        Given I am not logged in
        When I go to the members control panel page
        And I log in as a member with email "member@example.com" and password "password"
        Then I should be on the members control panel page
