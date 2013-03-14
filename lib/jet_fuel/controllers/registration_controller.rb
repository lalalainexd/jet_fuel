module JetFuel
  class RegistrationController

    def self.register(username, password1, password2)

      response = Response.new

      if valid_passwords? password1, password2

        user = create_user username, password1

        response.define_singleton_method(:success?) {user.errors.empty?}

        redirect = user.errors.empty? ? "/users/#{user.username}" : "/register"
        response.define_singleton_method(:redirect_to) {redirect}

      else
        response.define_singleton_method(:success?) {false}
        response.define_singleton_method(:redirect_to) {"/register"}
      end

      return response
    end

    def self.valid_passwords? password1, password2
      password1 == password2
    end

    def self.create_user username, password
      user = User.new username: username
      add_salt(user, password) if user.errors.empty?
      user.save
      return user
    end

    def self.add_salt user, password
      digest = Digest::SHA256.new
      result = digest.hexdigest user.username+password

      user.salt = result
    end

  end
end
