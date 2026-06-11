FROM ruby:3.3

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential libvips nodejs postgresql-client

WORKDIR /app

# ローカルのGemfileとGemfile.lockを一度コンテナ内にコピーする
COPY Gemfile Gemfile.lock ./

# イメージ作成時にすべてのGemを確実にインストールする
RUN bundle install

# サーバーの二重起動防止スクリプトを設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]