Feature: To test "has Tag"
    Background: I am on "Location" page

    Scenario: To See Tag
        When I click on "See All"
        And I click on "Post your own review"
        And I press the 5th star of the Rating field
        And I enter "I love this place!" into the Comment field
        And I click "Post Review"
        Then I see the review on the page
        And I see the review on my profile