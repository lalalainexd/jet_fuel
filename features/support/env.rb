$: << File.expand_path("../../lib", File.dirname(__FILE__))
require "jet_fuel"
require "capybara/cucumber"
require "yaml"

Capybara.app = JetFuel::Server
Capybara.default_driver = :selenium

db_config = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection db_config
