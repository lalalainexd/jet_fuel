require 'spec_helper'

module JetFuel
  describe AnalyticsController do

    before do
      urls = Array.new(3) do |i|
        url = double("mock url #{i}")
        url.stub(original: "http://www.url#{i}.com", short: "short#{i}", visits: i)
      end
      user = double("user mock")
      user.stub(urls: urls, username: "username")
      User.stub(:find_by_username).with("username").and_return(user)
    end

    it "responds with a list of urls and their shortend strings for a particular user" do
      response = AnalyticsController.analysis_for_user "username"
      expect(response.user.username).to eq "username"
      expect(response.user.urls.size).to eq 3
    end

  end
end
