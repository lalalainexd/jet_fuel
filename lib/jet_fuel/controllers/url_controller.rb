module JetFuel
  class UrlController

    def self.shorten address
      url = Url.find_or_create_by_original(address)

      response = Response.new
      response.define_singleton_method(:short_url) {url.short}
      return response
    end

    def self.visit short_url
      url = Url.find_by_short short_url
      url.visited
      url.save

      response = Response.new
      response.define_singleton_method(:original_url) {url.original}
      return response
    end

    def self.all_sorted_by_visits_and_dates
      visits = Url.order("visits desc")
      dates = Url.order("created_at desc")
      response = Response.new
      response.define_singleton_method(:urls_by_visit) {visits}
      response.define_singleton_method(:urls_by_date) {dates}
      return response
    end

    def self.shorten_with_vanity user, url, vanity
      PremiumUrl.create original: url, user: user, short: vanity

      response = Response.new
      response.define_singleton_method(:short_url) {vanity}
      return response
    end
  end
end
