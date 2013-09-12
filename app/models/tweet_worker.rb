class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    p "tweet id is:"
    p tweet_id
    tweet = Tweet.find(tweet_id)
    p tweet
    
    # set up Twitter OAuth client here
    current_user = User.find(tweet.user_id)
    user = Twitter::Client.new(
      :oauth_token => current_user.oauth_token,
      :oauth_token_secret => current_user.oauth_secret
      )
    p tweet.content
    user.update(tweet.content)    
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here

  end
end
