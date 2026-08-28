## 概要
作業記録ツールのバックエンド
dbとフロントとの負荷分散を実装予定

### 起動

VS codeのターミナルで`docker compose up` → `localhost:3001` で表示されたらok 


## その他注意点とか

Dockerを用いた開発経験

- モデルを作るとき:`docker compose exec web rails g model Task title:string status:integer`

- マイグレーション（DB反映）をするとき:`docker compose exec web rails db:migrate`

のように、従来のrailsコマンドの先頭に`docker compose exec web`を付ける。

wslを使用しているため、Docker側で Setting → Resource → WSL integration から設定をオンに


rails new を実行するとファイルの所有者がrootになり保存できなくなる場合がある。なんか色々変になって保存できなくなったときは

`sudo chown -R $USER:$USER ~/worklog/progress-recorder-backend`



## 他のPCでこの環境を再現する手順（クローンした後の流れ）
#### 1. リポジトリをクローンしてフォルダに入る
wslからやってね
`git clone https://github.com/kei5o55/progress-recorder-backend.git`
`cd progress-recorder-backend`

#### 2. 初回ビルド（Dockerfileを元に、Rubyや必要なGemを自動で全インストール）
`docker compose build`

#### 3. データベースの作成
`docker compose run web rails db:create`

#### 4. サーバー起動
`docker compose up`

## test
- ① 全てのテストを実行する場合
  `docker compose exec web bundle exec rspec`

- ② モデルテストだけ実行する場合
  `docker compose exec web bundle exec rspec spec/models/project_spec.rb`

- ③ APIリクエストテストだけ実行する場合
  `docker compose exec web bundle exec rspec spec/requests/api/v1/projects_spec.rb`

- ④ 特定の行（例: 15行目の it ブロック）だけピンポイントで実行する場合
  
  `docker compose exec web bundle exec rspec spec/requests/api/v1/projects_spec.rb:15`



## 工夫
- 画像URLの相対パス化による環境依存の排除
  - **課題**：バックエンド側で絶対パス(`https://locahost3000/`)を生成すると、将来的な本番環境へのデプロイ時にめんどくさくなりそう
  - **工夫**：Active Storageのレスポンスを相対パス（`/rails/active_storage/`)で返却、フロント側でurlと結合処理を施すことで環境によってバックエンド側のコード書き換えや不具合が発生しない柔軟な設計とした
