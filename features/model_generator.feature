Feature: Rails model generator
  In order to better do Test-Driven Development with Rails
  As a user
  I want to generate a Factory definition and Shoulda tests.

  Scenario: Model generator without attributes
    Given a Rails app
    And the coulda plugin is installed
    When I generate a model named "User"
    Then a factory should be generated for "User"
    And a unit test should be generated for "User"

  Scenario: Model generator with attributes
    Given a Rails app
    And the coulda plugin is installed
    When I generate a model "User" with a string "email"
    Then a factory for "User" should have an "email" string
    And a unit test should be generated for "User"

