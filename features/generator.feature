Feature: Rails model generator
  In order to automate factory definition
  A user should
  generate a factory file, not a fixture file when using the Rails generator

  Scenario: Model generator without options
    Given a Rails app
    And the coulda plugin is installed
    When I generate a model named "User"
    Then "test/factories/user.rb" has default factory definition for "User"

  Scenario: Model generator with attributes
    Given a Rails app
    And the coulda plugin is installed
    When I generate a model "User" with a string "email"
    Then "test/factories/user.rb" has factory definition for "User" with string attribute "email"

