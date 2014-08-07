ENV["RAILS_ENV"] = 'test'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require file }

require 'putio-rb'

RSpec.configure do |config|
  config.order = :random
end
