Feature: To test "Study At Night"
    Background: I want to go to <location>, to study at night

    Scenario: To see Open Hours at <Location>
        Given <Location> has Schedule
        When I go to <Location> page
        Then I can see the Schedule And I can see the closing hours