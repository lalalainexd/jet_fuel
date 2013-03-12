require 'spec_helper'

module JetFuel
  describe UrlController do


    context "Given an anonymous user of the system" do
      context "When the user visits the site" do
        let(:short_url) {"short_url"}
        let(:original_url) {"http://www.lalalainexd.com"}
        let(:url)  do
          double("mock url", short: short_url, original: original_url)
        end

        context "And gives a new URL to the service" do

          before do
            Url.stub(:create).with(original: original_url) {url}
          end

          it "then create a shortened URL" do
            Url.should_receive(:create).with(original: original_url)
            UrlController.shorten original_url
          end

          it "then return a shortened URL" do
            response = UrlController.shorten original_url
            expect(response.params[:short_url]).to eq short_url
          end
        end

        context "And gives duplicate URL to the service" do

          before do
            Url.stub(:find_by_original).with(original_url) {url}
          end

          it "then it doesn't create a new shortened URL" do
            Url.should_not_receive(:create).with(original: original_url)
            UrlController.shorten original_url
          end

          it "then return a shortened URL" do
            response = UrlController.shorten original_url
            expect(response.params[:short_url]).to eq short_url
          end

        end
      end
    end
  end
end
