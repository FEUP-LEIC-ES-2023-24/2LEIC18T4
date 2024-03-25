Feature: To test "Get Achievement"
    Background: I am on the <location>

    Scenario: To get an Achievement
        When I go to the <location>
        And I press Discover@ redeem medal
        Then I get an Achievement

Feature: To test "See Achievement"
    Background: I was on the <location>

    Scenario: To see an Achievement
        Given I have an Achievement
        When I press Discover@
        Then I see the Achievements
        When I press one Achievement
        Then I see the info about the Achievement