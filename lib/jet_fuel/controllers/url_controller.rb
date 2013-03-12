module JetFuel
  class UrlController

    def self.shorten address
      url = Url.find_by_original(address) || Url.create(original: address)
      Response.new 200, {short_url: url.short}
    end
  end
end
