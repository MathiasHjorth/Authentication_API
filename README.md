# Authentication_API V. 1.0
This is a minimal backend API project imitating a shopping app with user authentication capabilities. 
The project is mostly aimed at Pentia Mobile's hiring test for backend developers. It fulfills many of the requirements asked for in the test, but also leaves out some along with providing some that weren't a part of the assignment.
This is because the project was written under my 4th semester at UCL, and reservations for what i found most relevant for my exams took precedence over what the hiring test wanted.

The API's functionality and available endpoints are documented in the "Authentication_API V. 1.0 Pentia" document.

* Ruby version
  * Ruby 3.2.2

* System dependencies
  * Authentication dependencies
    * Devise
    * Devise-jwt
  * Database dependencies
    * PG gem
  * Fixes dependencies
    * This API includes a fix to the session store error in Rails 7.0.4.3 using Devise in an API only project. The module is found in controllers/concerns and explains briefly why it's needed.

* Configuration
  * Environment Variables:
    * This API is using local environment variables with the dot-env gem to authenticate with the database.
      To get it running, create a file named 'env' in the root folder.
      Create two keys named 'DATABASE_USER' and 'DATABASE_PASSWORD', as values provide the relevant information. The user credentials provided must have CRUD privileges along with being allowed to create tables.
  * Caching:
    * Run rails dev:cache in the terminal to enable caching in development mode
  * Test configuration:
    * You must setup the database test environment in database.yml to run tests
    * You must run the migrations for the test environment with db:migrate RAILS_ENV=test

* Database
  * Postgres v. 15.0

* Database creation
  * After having set up the environment variables under the Configuration steps
    * Run db:create
    * Run db:migrate
    * Run db:seed

* Testing
  * Testing of endpoints is done via Minitest
  * Run the test suite for the controllers via 'rails test test/api/v1' in the terminal
