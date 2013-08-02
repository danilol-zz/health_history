# -*- encoding : utf-8 -*-
Feature: Create User
  In order to create a user record
  As a api
  I want to have an endpoint that creates a user

  Scenario Outline: Failure by invalid attribute
    Given I have valid attributes to create an user
    And I change "<attribute>" value to "<invalid_value>"
    When I send a POST request to "/user" with this data
    Then the status code response should be "400"
    And the content type response should be JSON
    And the JSON response should have error for "<attribute>" with "<message>"

    Scenarios: Name/email is not sent or length is greater than allowed
    | attribute | invalid_value                                                                                                | message                                 |
    | name      |                                                                                                              | can't be blank                          |
    | name      | Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet | is too long (maximum is 100 characters) |
    | email     |                                                                                                              | can't be blank                          |
    | email     | Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod                      | is too long (maximum is 80 characters)  |

  Scenario: Failure by email conflicts
    Given that an user with email "testname@test.com" already exists
    When I send a POST request to "/user" with the following JSON:
    """
    {
      "cpf"   : "51178387000101",
      "name"  : "Test Name",
      "email" : "testname@test.com",
      "dob"   : "10/11/1950"
    }
    """
    Then the status code response should be "409"
    And the response body with the following JSON:
    """
    {
      "errors": { "email": ["is already taken"]}
    }
    """

  Scenario: Failure by name conflicts
    Given that an user with name "Test" already exists
    When I send a POST request to "/user" with the following JSON:
    """
    {
      "cpf"   : "51178387000101",
      "name"  : "Test",
      "email" : "testname@test.com",
      "dob"   : "10/11/1950"
    }
    """
    Then the status code response should be "409"
    And the response body with the following JSON:
    """
    {
    "errors": { "name": ["is already taken"], "email": [] }
    }
    """

  Scenario: Success
    When I send a POST request to "/user" with the following JSON:
    """
    {
      "cpf"   : "51178387000101",
      "name"  : "Test Name",
      "email" : "testname@test.com",
      "dob"   : "10/11/1950"
    }
    """
    Then the status code response should be "201"
    And the content type response should be JSON
    And the response body with following href in the header location
