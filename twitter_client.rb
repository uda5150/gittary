require 'twitter'
require 'date'
require_relative './client.rb'
require_relative './github_client.rb'


module Gittary
  class TwitterClient

    def initialize
      client = Gittary::Client.new
      @twitter = client.twitter
    end

    def tweet(text)
      @twitter.update(text)
    end

    def show_my_profile
      @user_info = @twitter.user.screen_name, @twitter.user.name
    end

  end
end

github = Gittary::GithubClient.new
twitter = Gittary::TwitterClient.new

day = Date.today - 1
p Time.now

my_profile = twitter.show_my_profile

if github.get_num_commit_repos("#{day}").zero?
  message = "#{my_profile[1]}(@#{my_profile[0]})は#{day}のコミットは0でした #gittary"
else
  message = "#{my_profile[1]}(@#{my_profile[0]})は#{day}に#{github.get_num_commit_repos("#{day}")}個のレポジトリに合計#{github.get_num_commits("#{day}")}回コミットしました。#gittary"
end

# TODO
# なにか拾ってないアクティビティがあるっぽい
# github上でのコミットが拾われていない気がする
# pushから拾っているからかもしれない

p message
twitter.tweet(message)
