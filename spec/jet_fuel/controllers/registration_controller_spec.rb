require 'spec_helper'

module JetFuel
  describe RegistrationController do

    it "can create a new user" do
     response = described_class.register "new_user", "the_password", "the_password"
     expect(response).to be_success
     expect(response.redirect_to).to eq "/users/new_user"
    end

    it "can create another user" do
     response = described_class.register "new_user2", "the_password", "the_password"
     expect(response).to be_success
     expect(response.redirect_to).to eq "/users/new_user2"
    end

    it "asks for a new username when the username is already taken" do
     response = described_class.register "new_user", "the_password", "the_password"
     response = described_class.register "new_user", "the_password", "the_password"
     expect(response).to_not be_success
     expect(response.redirect_to).to eq "/register"
    end

    it "redirects when the passwords don't match" do
     response = described_class.register "new_user", "the_password", "womp"
     expect(response).to_not be_success
     expect(response.redirect_to).to eq "/register"
    end

    it "generates salt for the user" do
     response = described_class.register "new_user", "womp", "womp"

     user = User.find_by_username("new_user")

     digest = Digest::SHA256.new
     salt = digest.hexdigest "new_userwomp"

    expect(user.salt).to eq salt


    end
  end
end
