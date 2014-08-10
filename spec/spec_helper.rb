ENV["RAILS_ENV"] = 'test'

require 'putio-rb'
require 'rspec'
require 'webmock/rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.order = :random
end
