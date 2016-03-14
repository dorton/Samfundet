Feature: Steal user identity
    As a superadmin
    I want to steal the identity of a different user
    In order to hunt bugs or infringe their privacy

    Background:
        Given I am a member in "LIM" with roles "lim_web"

    # This test is problematic because members are looked up up by ID, not by
    # email address, and we can't access that ID in Cucumber. The actual input
    # field is populated by jQuery autocomplete; however, testing AJAX doesn't
    # seem worth the trouble at the moment.
    #
    # Scenario: Steal identity of member
    #     Given there is a member with email "user@example.org"
    #     And I am on the members control panel page
    #     And I fill in the following:
    #         | member_id | user@example.org |
    #     And I press "Stjel identitet til medlem"
    #     Then I should be logged in as a member with email "user@example.org"
    #     And I should be on the home page

    Scenario: Steal identity of applicant
        Given there is an applicant with email "user@example.org"
        And I am on the members control panel page
        And I fill in the following:
            | applicant_email | user@example.org |
        And I press "Stjel identitet til søker"
        Then I should be logged in as an applicant with email "user@example.org"
        And I should be on the home page
