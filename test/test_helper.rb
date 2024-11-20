ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def authenticate(user:)
      session = user.sessions.create!(user_agent: "TEST", ip_address: "1234567890")
      Current.session = session
      cookie_jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      cookie_jar.signed.permanent[:session_id] = {
        value: session.id,
        httponly: true,
        same_site: :lax
      }
      cookies[:session_id] = cookie_jar[:session_id]
    end
  end
end
