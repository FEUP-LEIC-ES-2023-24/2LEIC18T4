Feature: Search
    The search bar input should take me to a location with the corresponding name
    Scenario: Go to "Casa da Música" when searched
        Given I am on Home menu
        When I fill the "Where do you want to study at?" text field with "Casa da Música"
        And I press enter
        Then I expect the map to be in "Casa da Música"