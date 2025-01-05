ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include ApplicationHelper

    # Return true if a tst user is logged in.
    # Not including this in ApplicationHelper because
    # I don't want this to be accessible throughout the
    # rest of the application
    def is_logged_in?
      !session[:user_id].nil?
    end
  end
end
