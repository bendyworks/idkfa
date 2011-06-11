Feature: The init CLI command
  In order to start using idkfa
  As a user
  I want to initialize my system and project

  Scenario: Init without config directory
    Given the home directory is stubbed to "/tmp"
      And RSA key generation is stubbed
      And the project directory is stubbed to "/tmp/project"
    When I run the "init" cli command
    Then a directory named "/tmp/.idkfa" should exist
      And the following files should exist:
        | /tmp/.idkfa/default.public.yml   |
        | /tmp/.idkfa/.default.private.yml |
      And the file "/tmp/project/credentials.yml" should contain:
      """
      --- 
      keys: 
      - id: login@computer
        public_key: pub_key
        symmetric_key: sym_key
      """
