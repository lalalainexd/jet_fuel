module JetFuel
  class Response

    attr_reader :params, :status

    def initialize status=200, params
      @params = params
      @status = status
    end
  end
end
