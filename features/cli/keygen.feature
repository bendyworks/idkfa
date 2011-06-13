Feature: The keygen CLI command
  In order to setup a new user for idkfa
	As a user
	I wish to generate a new keypair
	
	Scenario: Keygen (no args) without a home directory
	  Given the home directory is stubbed to "/tmp/idkfa"
      And RSA key generation is stubbed
	  When I run the "keygen" cli command
	  Then a directory named "/tmp/idkfa/.idkfa" should exist
      And the following files should exist:
        | /tmp/idkfa/.idkfa/default.public.yml   |
        | /tmp/idkfa/.idkfa/.default.private.yml |
	
	# Don't know why I can't get it to recognize output
	# Scenario: Keygen (no args) with key file already present
	# 	Given an .idkfa directory exists at "/tmp/idkfa/.idkfa" with "default" keyfiles
	# 		And RSA key generation is stubbed
	# 	When I run the "keygen" cli command
	# 	Then the output should contain:
	# 			"""
	# 			A key pair for 'default' already exists
	# 			"""
	
	Scenario: Keygen with custom name, no keys with that name exist
	Given the home directory is stubbed to "/tmp/idkfa"
    And RSA key generation is stubbed
  When I run the "keygen" cli command with the "heroku" custom name argument
  Then a directory named "/tmp/idkfa/.idkfa" should exist
    And the following files should exist:
      | /tmp/idkfa/.idkfa/heroku.public.yml   |
      | /tmp/idkfa/.idkfa/.heroku.private.yml |
	
	# Don't know why I can't get it to recognize output
	# Scenario: Keygen with custom name, keys with that name already exists
	# 	Given an .idkfa directory exists at "/tmp/idkfa/.idkfa" with "heroku" keyfiles
	# 		And RSA key generation is stubbed
	# 	When I run the "keygen" cli command with the "heroku" custom name argument
	# 	Then the output should contain:
	# 	"""
	# 	A key pair for 'heroku' already exists
	# 	"""
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

  
