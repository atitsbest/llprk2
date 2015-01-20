ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Include class extensions.
Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }

FakeWeb.allow_net_connect = false

class ActiveSupport::TestCase

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

  def fake_paypal_response(file_path, options = {})
      endpoint = Paypal::NVP::Request.endpoint

      FakeWeb.register_uri(
          :post,
          endpoint,
          options.merge(
              :body => File.read(File.join(File.dirname(__FILE__), 'fixtures/fake_paypal_responses', "#{file_path}.txt"))
          )
      )
  end

end
