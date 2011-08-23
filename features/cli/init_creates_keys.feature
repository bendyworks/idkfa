Feature: The init CLI command creates keys
  In order to start using idkfa
  As a user
  I want to use init to create keys

  Background:
    Given directories and rsa generation are stubbed

  Scenario: Init creates default keys
    When I run the "init" cli command
    Then a directory named "/tmp/idkfa/.idkfa" should exist
      And the following files should exist:
        | /tmp/idkfa/.idkfa/default.public.yml   |
        | /tmp/idkfa/.idkfa/.default.private.yml |

  Scenario: Init with -k flag customizes key names
    When I run the "init" cli command with "-k heroku"
    Then a directory named "/tmp/idkfa/.idkfa" should exist
      And the following files should exist:
        | /tmp/idkfa/.idkfa/heroku.public.yml   |
        | /tmp/idkfa/.idkfa/.heroku.private.yml |
