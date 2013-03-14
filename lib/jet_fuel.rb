require "jet_fuel/version"

require "digest"
require "haml"

require "sinatra"
require "sinatra/activerecord"
require "server"

require "jet_fuel/controllers/response"
require "jet_fuel/controllers/url_controller"
require "jet_fuel/controllers/registration_controller"
require "jet_fuel/controllers/login_controller"
require "jet_fuel/controllers/analytics_controller"

require "jet_fuel/models/url"
require "jet_fuel/models/premium_url"
require "jet_fuel/models/user"

configure do
  set :public_folder, 'public'
end

module JetFuel
  # Your code goes here...
end

