class Url < ActiveRecord::Base
  validates :original, :short, presence: true, uniqueness: true
  after_initialize :init

  def init
    self.visits ||= 0
    self.short ||= new_short_url
  end

  def new_short_url
    6.times.inject("") do |val|
      val + random_char
    end
  end

  def random_char
    [('a'..'z'),('A'..'Z'),(1..2)].sample.to_a.sample.to_s
  end

  def visited
    self.visits += 1
  end

end
