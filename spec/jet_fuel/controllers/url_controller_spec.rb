require 'spec_helper'

module JetFuel
  describe UrlController do

    context "Given an anonymous user of the system" do
      let(:short_url) {"short_url"}
      let(:original_url) {"http://www.lalalainexd.com"}
      let(:url)  do
        double("mock url", short: short_url,
               original: original_url, visited: true, save: true)
      end

      before do
        Url.stub(:find_or_create_by_original).with(original_url) {url}
        Url.stub(:find_by_short).with(short_url) {url}
      end

      context "When the user requests to shorten a URL" do

        context "And the URL is not a duplicate" do


          it "then create a shortened URL" do
            Url.should_receive(:find_or_create_by_original).with(original_url)
            UrlController.shorten original_url
          end

          it "then return a shortened URL" do
            response = UrlController.shorten original_url
            expect(response.short_url).to eq short_url
          end
        end

        context "And the URL is a duplicate" do
          it "then find the shortened URL" do
            Url.should_receive(:find_or_create_by_original).with(original_url)
            UrlController.shorten original_url
          end

          it "then return a shortened URL" do
            response = UrlController.shorten original_url
            expect(response.short_url).to eq short_url
          end

        end
      end

      context "When the user provides a shortened URL" do

        context "And the shortended URL is associated with an original" do

          it "then return the original URL" do
            response = UrlController.visit short_url
            expect(response.original_url).to eq original_url
          end

          it "then increment the number of requests to that short url" do
            url.should_receive(:visited).exactly(3).times
            UrlController.visit short_url
            UrlController.visit short_url
            UrlController.visit short_url
          end

          it "then update the number of requests to that short url" do
            url.should_receive(:save)
            UrlController.visit short_url
            pending
          end
        end
      end
    end
  end
end
