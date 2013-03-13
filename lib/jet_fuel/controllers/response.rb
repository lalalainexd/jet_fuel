module JetFuel
  class Response

    attr_reader :status, :errors

    def initialize status=200, errors=nil
      @status = status
      @errors = errors
    end
  end
end
