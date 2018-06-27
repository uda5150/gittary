## gittary
Gitクライアントから、1日のコミット数を自動でTweetしてくれます（個人用）  
※ 要herokuの設定

## 残タスク
- GitLab等のGitHub以外のGitクライアントのコミット数を出せるようにする
- 連続コミット日数が分かるようにする
- tweetページの作成

## ユーザー設定
- .env の準備
- heroku configのインストール＆.envのPush
```
heroku plugins:install heroku-config
heroku config:push
```