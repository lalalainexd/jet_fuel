module JetFuel
  class PremiumUrl < ActiveRecord::Base
    validates :original, :short, presence:true
    belongs_to :user
    after_initialize :init

    def init
      @visits ||= 0
    end


  end
end
