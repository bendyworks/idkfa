Feature: The init CLI command creates a credentials file
  In order to start using idkfa
  As a user
  I want to use init to create a credentials file

  Background:
    Given directories and rsa generation are stubbed

  Scenario: Init without config directory creates base credentials.yml
    When I run the "init" cli command
    Then a directory named "/tmp/idkfa/.idkfa" should exist
      And the following files should exist:
        | /tmp/idkfa/.idkfa/default.public.yml   |
        | /tmp/idkfa/.idkfa/.default.private.yml |
      And the file "/tmp/idkfa/project/credentials.yml" should contain:
      """
      ---
      keys:
      - id: login@computer
        public_key: pub_key
        symmetric_key: sym_key
      content: abc123
      """

  Scenario: Init with config directory creates config/credentials.yml
    Given the project directory contains "config"
    When I run the "init" cli command
    Then the file "/tmp/idkfa/project/config/credentials.yml" should contain:
      """
      ---
      keys:
      - id: login@computer
        public_key: pub_key
        symmetric_key: sym_key
      content: abc123
      """

  Scenario: Init with -c flag customizes credentials file location
    When I run the "init" cli command with "-c cred.yml"
    Then the file "/tmp/idkfa/project/cred.yml" should contain:
      """
      ---
      keys:
      - id: login@computer
        public_key: pub_key
        symmetric_key: sym_key
      content: abc123
      """
