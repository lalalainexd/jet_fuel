require 'jet_fuel'
require 'yaml'
require 'haml'

set :run, false
set :raise_errors, true

RSpec.configure do |config|
  config.order = 'random'

  config.around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end

db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection db_config[:test]
