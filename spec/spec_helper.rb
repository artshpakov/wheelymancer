RACK_ENV = 'test'

require File.expand_path("../../init", __FILE__)
require 'factories'


module ApiHelper
  include Rack::Test::Methods

  def app
    Wheelymancer
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.include ApiHelper, type: :controller
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def json_response
  JSON.parse last_response.body if last_response
end
