Feature: To test "Add To Favourite"
    Background: I was on the <location> and want to save it

    Scenario: To add to Favourite
        Given I want to Favourite <Location>
        When I go to the <Location> page And press Star
        Then I add <Location> to the Favourites

Feature: To test "See Favourite"
    Background: I want to go my favourite location, <location>

    Scenario: To see Favourite Location
        Given I have Favourite Location
        When I press Starred
        Then I can see the Favourite Location