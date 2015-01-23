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

    # Runs assert_difference with a number of conditions and varying difference
    # counts.
    #
    # Call as follows:
    #
    # assert_differences([['Model1.count', 2], ['Model2.count', 3]])
    #
    def assert_differences(expression_array, message = nil, &block)
        b = block.send(:binding)
        before = expression_array.map { |expr| eval(expr[0], b) }

        yield

        expression_array.each_with_index do |pair, i|
            e = pair[0]
            difference = pair[1]
            error = "#{e.inspect} didn't change by #{difference}"
            error = "#{message}\n#{error}" if message
            assert_equal(before[i] + difference, eval(e, b), error)
        end
    end

end
