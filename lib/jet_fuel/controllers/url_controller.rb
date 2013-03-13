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
  end
end
