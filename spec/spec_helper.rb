ENV["RAILS_ENV"] = 'test'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require file }

require 'putio'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = :random
end
