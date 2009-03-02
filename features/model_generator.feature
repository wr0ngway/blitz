Feature: Rails model generator
  In order to automate factory definition
  A user should
  generate a factory file, not a fixture file when using the Rails generator

  Scenario: Model generator without attributes
    Given a Rails app
    And the coulda plugin is installed
    When I generate a model named "User"
    Then a factory should be generated for "User"

  Scenario: Model generator with attributes
    Given a Rails app
    And the coulda plugin is installed
    When I generate a model "User" with a string "email"
    Then a factory for "User" should have an "email" string

