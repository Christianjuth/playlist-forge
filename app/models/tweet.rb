class Tweet
  attr_accessor :username, :msg
  ALL_TWEETS = []

  def initialize(username, msg)
    @username = username.downcase
    @msg = msg
    ALL_TWEETS.push(self)
  end

  def self.all
    ALL_TWEETS
  end
end