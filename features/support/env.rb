$: << File.expand_path("../../lib", File.dirname(__FILE__))
require "jet_fuel"
require "capybara/cucumber"
require "yaml"

Capybara.app = JetFuel::Server
Capybara.default_driver = :selenium

db_config = YAML::load(File.open('config/database.yml'))
puts db_config.inspect
ActiveRecord::Base.establish_connection db_config[:test]
