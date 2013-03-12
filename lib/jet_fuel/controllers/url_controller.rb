module JetFuel
  class UrlController

    def self.shorten address
      url = Url.find_or_create_by_original(address)
      Response.new short_url: url.short
    end

    def self.visit short_url
      url = Url.find_by_short short_url
      url.visited
      url.update

      Response.new original: url.original
    end
  end
end
