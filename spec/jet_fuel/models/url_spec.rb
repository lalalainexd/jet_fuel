require 'spec_helper'

module JetFuel
  describe Url do

    context "shortens the url" do
      it "shortens the url" do
        original = "http://lalalainexd.com"
        url = Url.create original: original

        pending

        expect(url.original).to eq original
        expect(url.short.length).to eq 6
        expect(url.id).to eq 1

      end

      it "doesn't create a new url" do
        original = "http://blah.com"
        url = Url.create original: original
        url2 = Url.find_or_create_by_original original

        expect(url.id).to eq url2.id
        expect(url.short).to eq url2.short


      end
    end



    it "adds 1 to the number of times visited" do
      original = "http://lalalainexd.com"
      url = Url.create original: original

      url.visited

      expect(url.visits).to eq 1
    end

  end
end
