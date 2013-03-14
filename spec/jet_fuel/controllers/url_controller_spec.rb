require 'spec_helper'

module JetFuel
  describe UrlController do

    it "returns a list of urls sorted most visits" do
      response1 = described_class.shorten 'http://www.facebook.com'
      response2 = described_class.shorten 'http://www.google.com'
      response3 = described_class.shorten 'http://www.yahoo.com'

      3.times { described_class.visit response3.short_url }
      2.times { described_class.visit response2.short_url }
      1.times { described_class.visit response1.short_url }

      response = described_class.all_sorted_by_visits_and_dates

      expect(response.urls_by_visit.size).to eq 3
      expect(response.urls_by_visit[0].short).to eq response3.short_url
      expect(response.urls_by_visit[1].short).to eq response2.short_url
      expect(response.urls_by_visit[2].short).to eq response1.short_url
    end

    context "Given a logged in user" do
      before do
        RegistrationController.register "username", "password", "password"
#        LoginController.login "username", "password"

      end

      let(:user) {
        User.find_by_username "username"
      }

      it "creates a url for the user with the vanity string" do
        pending
       #user_url = described_class.shorten_with_vanity(user,
        #                                       "http://www.google.com", "supdum").short_url
        #expect(user_url).to eq "supdum"
      end
    end

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
