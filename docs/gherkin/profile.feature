Feature: To test "edit username"
    Background: I am on "Edit Profile" page

    Scenario: To change the username
        When I click on "Username" field
        And I enter "@CoolStudent123" into the "Username" field
        And I click "Save info"
        Then I see the new username on my profile

Feature: To test "edit name"
    Background: I am on "Edit Profile" page

    Scenario: To change the name
        When I click on "Name" field
        And I enter "José Rodrigues" into the "Name" field
        And I click "Save info"
        Then I see the new name on my profile

Feature: To test "edit faculty"
    Background: I am on "Edit Profile" page

    Scenario: To change the faculty
        When I click on "Faculty" field
        And I select one of the available faculties in the "Faculty" field
        And I click "Save info"
        Then I see the new faculty on my profile

Feature: To test "edit About you"
    Background: I am on "Edit Profile" page

    Scenario: To change the biography
        When I click on "About you" field
        And I enter "Proud FEUP student :D" into the "About you" field
        And I click "Save info"
        Then I see the new biography on my profile