require 'spec_helper'

module JetFuel
  describe Url do
    it "shortens the url" do
      original = "http://lalalainexd.com"
      url = Url.create original: original

      pending

      expect(url.original).to eq original
      expect(url.short.length).to eq 6
      expect(url.id).to eq 1

    end

    it "adds 1 to the number of times visited" do
      original = "http://lalalainexd.com"
      url = Url.create original: original

      url.visited

      expect(url.visits).to eq 1
    end

  end
end
