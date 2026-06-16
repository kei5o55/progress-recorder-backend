## 概要
作業記録ツールのバックエンド
dbとフロントとの負荷分散を実装予定

### 起動

VS codeのターミナルで`docker compose up` → `localhost:3000` で表示されたらok

## その他注意点とか

Dockerを用いた開発経験

- モデルを作るとき:`docker compose exec web rails g model Task title:string status:integer`

- マイグレーション（DB反映）をするとき:`docker compose exec web rails db:migrate`

のように、従来のrailsコマンドの先頭に`docker compose exec web`を付ける。

wslを使用しているため、Docker側で Setting → Resource → WSL integration から設定をオンに


rails new を実行するとファイルの所有者がrootになり保存できなくなる場合がある。なんか色々変になって保存できなくなったときは

`sudo chown -R $USER:$USER ~/src/progress-recorder-backend`

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
