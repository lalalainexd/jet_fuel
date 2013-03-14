module JetFuel
  class User < ActiveRecord::Base
    validates :username, :uniqueness => true, :presence => true
    has_many :premium_urls
  end
end
