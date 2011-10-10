@javascript
Feature:
  As a content editor type person
  In order to manage my mail templates
  I should be able to edit, publish and send a test.

  Background:
    Given some templates exists
      And I go to the home page
      And I follow "Templates"
      And I follow "cc_welcome"


  Scenario: A user can publish their changes
    Given I press "Publish" in the content frame
    Then I should see "Published" in the content frame