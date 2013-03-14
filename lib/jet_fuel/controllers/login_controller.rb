module JetFuel
  class LoginController

    def self.can_login? username, password
      puts "!!!!!!!!!!!!!!!!!!!!!can login?"
      user = User.find_by_username username
      puts user.inspect
      response = Response.new

      if user && valid_password(user, password)
        cookie = generate_cookie user.username
        response.define_singleton_method(:cookie) {cookie}
      else
        response.define_singleton_method(:cookie){nil}
      end

      puts "maybe?"
      return response
    end

    def self.valid_password user, password
     digest = Digest::SHA256.new
     generated_salt = digest.hexdigest(user.username+password)
     user.salt == generated_salt
    end

    def self.generate_cookie username
      digest = Digest::SHA256.new
      digest.hexdigest(username)[0..9]
    end

    def self.logged_in? username, cookie
      response = Response.new
      logged_in = has_cookie? username, cookie
      response.define_singleton_method(:logged_in?) {logged_in}
      return response

    end

    def self.has_cookie? username, cookie
      generate_cookie(username) == cookie
    end

  end

end
