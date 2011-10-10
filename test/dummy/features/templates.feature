@javascript
Feature:
  As a content editor type person
  In order to manage my mail templates
  I should be able to edit, publish and send a test.

  Background:
    Given some templates exists

  Scenario: A user can publish their changes
    Given I go to the url: "/templates"
      And I follow "cc_welcome"
      And I press "Publish" in the content frame
    Then I should see "Published" in the content frame