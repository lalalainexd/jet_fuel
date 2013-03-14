require 'spec_helper'

module JetFuel
  describe LoginController do

    def generate_cookie username
     digest = Digest::SHA256.new
     cookie = digest.hexdigest(username)[0..9]
    end

    it "validates that the user is allowed to login" do
      RegistrationController.register "username", "password", "password"
      response = described_class.can_login? "username", "password"
      expect(response.cookie).to eq generate_cookie("username")
    end

    it "doesnt log in a user not in the db" do
      response = described_class.can_login? "username", "password"
      expect(response.cookie).to be_nil
    end

    it "doesnt login an incorrect username/password pair" do
      RegistrationController.register "username", "password", "password"
      response = described_class.can_login? "username", "password1"
      expect(response.cookie).to be_nil
    end

    it "confirms the user is logged in" do
      response = LoginController.logged_in? "username", generate_cookie("username")
      expect(response).to be_logged_in

    end

  end
end
