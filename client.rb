
require 'octokit'
require 'dotenv'
require 'twitter'


module Gittary
  class Client
    Dotenv.load

    def user
      @user_id = 'uda5150'
    end
    
    def github
      @client ||= Octokit::Client.new(
        login: ENV['GITHUB_USERNAME'],
        password: ENV['GITHUB_PASSWORD'],
        per_page: 100
        )
    end
    
    def gitlab

    end

    def twitter
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end
  end
end

