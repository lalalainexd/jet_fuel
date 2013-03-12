module JetFuel
  class UrlController

    def self.create address
      url = Url.create original: address
    end

    def self.visit short_url
      url = Url.find_by_short(short_url)
      url.visited
      url.save

      return url
    end
  end
end
