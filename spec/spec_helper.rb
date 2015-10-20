require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.disable_monkey_patching!
end