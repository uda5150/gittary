
require 'octokit'
require 'pp'
require_relative './client.rb'

module Gittary
  class GithubClient

    def initialize
      client = Gittary::Client.new
      @user_id = client.user
      @github = client.github
    end

    # 日付を渡すとユーザーがその日にpushしたレポジトリのリストを返す
    def get_push_events(date)

      # 日本の日付からUTCの日付開始時間と終了時間の取得
      @start_at = Time.parse(date).getutc
      @end_at = @start_at + (60 * 60 * 24).seconds

      # イベントからプッシュしたレポジトリの取得
      repo_list = []

      events = @github.user_events(@user_id)
      events.each do |event|
        if event[:type] == 'PushEvent' && event[:created_at] >= @start_at && event[:created_at] < @end_at
          repo_list << event[:repo][:name]
        end
      end

      repo_list
    end

    def get_num_commit_repos(date)

      repo_list = get_push_events(date)

      if repo_list.length.zero?
        0
      end

      repo_list.uniq.length
    end
    

    # 日付を受け取るとコミット数を返す
    def get_num_commits(date)
      
      repo_list = get_push_events(date)

      if repo_list.length.zero?
        0
      end

      # レポジトリと日付からコミット数を算出する
      # commit_betweenがリストを返しているので、リストのリストになっている・・・
      commits = []
      repo_list.uniq.each do |repo|
        @github.commits_between(repo, @start_at, @end_at).each do |commit|
          commits << commit
        end 
      end

      commits.length
    end
    
  end
end

