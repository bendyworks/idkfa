Feature: The keygen CLI command with a custom name
  In order to setup a new user for idkfa
  As a user
  I want to generate a new keypair with a custom name

  Background:
    Given RSA key generation is stubbed

  Scenario: Keygen with custom name, no keys with that name exist
    Given the home directory is stubbed to "/tmp/idkfa"
    When I run the "keygen" cli command with the "heroku" custom name argument
    Then the following files should exist:
      | /tmp/idkfa/.idkfa/heroku.public.yml   |
      | /tmp/idkfa/.idkfa/.heroku.private.yml |

  Scenario: Keygen with custom name, keys with that name already exists
    Given an .idkfa directory exists at "/tmp/idkfa/.idkfa" with "heroku" keyfiles
    When I run `idkfa keygen heroku`
    Then the exit status should be 1
    And the output should contain:
    """
    A key pair for 'heroku' already exists
    """
