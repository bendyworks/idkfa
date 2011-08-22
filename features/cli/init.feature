Feature: The init CLI command
  In order to start using idkfa
  As a user
  I want to initialize my system and project

  Scenario: Init without config directory
    Given the home directory is stubbed to "/tmp/idkfa"
      And RSA key generation is stubbed
      And the project directory is stubbed to "/tmp/idkfa/project"
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
      """

  Scenario: Init with config directory
    Given the home directory is stubbed to "/tmp/idkfa"
      And RSA key generation is stubbed
      And the project directory is stubbed to "/tmp/idkfa/project"
      And the project directory contains "config"
    When I run the "init" cli command
    Then a directory named "/tmp/idkfa/.idkfa" should exist
      And the following files should exist:
        | /tmp/idkfa/.idkfa/default.public.yml   |
        | /tmp/idkfa/.idkfa/.default.private.yml |
      And the file "/tmp/idkfa/project/config/credentials.yml" should contain:
      """
      ---
      keys:
      - id: login@computer
        public_key: pub_key
        symmetric_key: sym_key
      """

  Scenario: Init with -c flag
    Given the home directory is stubbed to "/tmp/idkfa"
      And RSA key generation is stubbed
      And the project directory is stubbed to "/tmp/idkfa/project"
    When I run the "init" cli command with "-c cred.yml"
    Then a directory named "/tmp/idkfa/.idkfa" should exist
      And the following files should exist:
        | /tmp/idkfa/.idkfa/default.public.yml   |
        | /tmp/idkfa/.idkfa/.default.private.yml |
      And the file "/tmp/idkfa/project/cred.yml" should contain:
      """
      ---
      keys:
      - id: login@computer
        public_key: pub_key
        symmetric_key: sym_key
      """
