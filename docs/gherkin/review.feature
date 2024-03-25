Feature: To test "Write Reviews"
    Background: I am on <location> page

    Scenario: To Write a Review
        Given I visited <location>
        When I click on "See All"
        And I click on "Post your own review"
        And I press the 5th star of the Rating field
        And I enter "I love this place!" into the Comment field
        And I click "Post Review"
        Then I see the review on the page
        And I see the review on my profile

Feature: To test "Read Reviews"
    Background: I am on <location> page

    Scenario: To Read a Review
        When I click on "See All"
        Then I see the reviews on the page

