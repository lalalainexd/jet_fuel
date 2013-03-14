module JetFuel
  class AnalyticsController

    def self.analysis_for_user username
      user = User.find_by_username username

      response = Response.new
      response.define_singleton_method(:user) {user}
      return response

    end

  end

end
