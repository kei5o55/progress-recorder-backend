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
## 💡 設計の工夫・技術的こだわり

### 1. API境界（中間層）におけるデータ表現（CamelCase / snake_case）の吸収

フロントエンド（TypeScript/React）とバックエンド（Ruby on Rails/PostgreSQL）でそれぞれ最適な命名規則を守りつつ、開発効率とコードの堅牢性を両立させる設計を採用しました。

#### ⚖️ 設計思想と採用したアプローチ
- **各レイヤーの文化を尊重:**
  - フロントエンド: JavaScript / TypeScript の標準である **`camelCase`** (`dueDate`, `durationMs`)
  - バックエンド: Ruby / Rails / SQL の標準である **`snake_case`** (`due_date`, `duration_ms`)
- **境界線（Strong Parameters）での相互変換:**
  データが各層（フロントの画面描画、Railsのモデル・DB操作）に入り込む手前の中間層（コントローラーの Strong Parameters）で相互変換を完結させています。

#### 🛠️ 具体的な実装
- **リクエスト時 (Frontend ➔ Backend):**
  フロントエンドからは `camelCase` のまま送信し、Rails の `Strong Parameters` 内で `snake_case` のハッシュへマッピングして受け取ります。
  
  ```ruby
  # app/controllers/api/v1/commits_controller.rb
  def commit_params
    # 1. フロントから届いた camelCase パラメータを許可
    p = params.require(:commit).permit(:durationMs, :startedAt, :endedAt, :note)

    # 2. バックエンド内部（ActiveRecord）用へ snake_case にマッピング
    {
      duration_ms: p[:durationMs],
      started_at:  p[:startedAt],
      ended_at:    p[:endedAt],
      note:        p[:note]
    }
  end
