require 'spec_helper'

module JetFuel
  describe UrlController do

    it "saves a new url" do
      url = described_class.create "http://www.lalalainexd.com"

      expect(url.short).to_not be_nil
      expect(url.id).to eq 1
    end

    it "adds 1 to the visit value of a short url" do
      url = described_class.create "http://www.lalalainexd.com"
      described_class.visit url.short
      found_url = Url.find_by_id(url.id)

      expect(found_url.visits).to eq 1
    end

  end
end
