Feature: Manage Interviews
    In order for interviewees to be admitted
    As a group responsible
    I want to organize interviews and set their wanted status

    Background:
        Given the following groups exist: "MG", "TSS", "Sangern"
        And there are open admissions titled Spring Admission 2011
        And I am a member in "MG" with roles "mg_opptaksansvarlig"
        And there are jobs for "MG" in "Spring Admission 2011" titled "Hore", "Bukk", "Pimp"
        And "Jonas Myrlund" has applied for "Hore" with motivation "Fordi atte."
        And "Mr Mister" has applied for "Pimp" with motivation "Jasså."
        And "Mr Mister" has applied for "Hore" with motivation "Hore."

    Scenario: See job applications on overview page
        Given I am on the group interviews page for "MG" in "Spring Admission 2011"
        Then I should see the following:
            | Bukk            | 0      |
            | Hore            | 2      |
            | Pimp            | 1      |

    Scenario: See job details when clicked
        Given I am on the group interviews page for "MG" in "Spring Admission 2011"
        And I follow "Hore"
        Then I should see "Applications for Hore"
        Then I should see "Jonas Myrlund"
        And I should see "Mr Mister"

    Scenario: Set job interview time
        Given I am on the group interviews page for "MG" in "Spring Admission 2011"
        And I follow "Hore"
        And I fill in the following:
            | interview_1_time | 22.09.2011 22:11 |
        Then the "interview_1_time" field should contain "22.09.2011 22:11"
        And I select "Wanted" from "interview_1_acceptance_status"
        And the "interview_1_acceptance_status" field should contain "wanted"

    Scenario: See job application details when clicked
        Given I am on the group interviews page for "MG" in "Spring Admission 2011"
        And I follow "Hore"
        And I follow "Jonas Myrlund"
        Then I should be on Jonas Myrlund's job application page for "Hore"
        And I should see "Fordi atte."

    Scenario: See the applicant's priorities when clicked
        Given I am on the group interviews page for "MG" in "Spring Admission 2011"
        And I follow "Pimp"
        And I follow "Mr Mister"
        Then I should be on Mr Mister's job application page for "Pimp"
        And I should see the following:
            | 1. | Hore | MG |
            | 2. | Pimp | MG |
