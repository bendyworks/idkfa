Feature: The keygen CLI command with default name
  In order to setup a new user for idkfa
  As a user
  I want to generate a new keypair with the default name

  Scenario: Keygen (no args) without a home directory
    Given the home directory is stubbed to "/tmp/idkfa"
    And RSA key generation is stubbed
    When I run the "keygen" cli command
    Then the following files should exist:
      | /tmp/idkfa/.idkfa/default.public.yml   |
      | /tmp/idkfa/.idkfa/.default.private.yml |

  Scenario: Keygen (no args) with key file already present
    Given an .idkfa directory exists at "/tmp/idkfa/.idkfa" with "default" keyfiles
    And RSA key generation is stubbed
    When I run `idkfa keygen`
    Then the exit status should be 1
    And the output should contain:
    """
    A key pair for 'default' already exists
    """
