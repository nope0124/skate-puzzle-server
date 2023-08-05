# ベースイメージをRuby 3.0に設定します。
FROM ruby:3.0

# 必要なパッケージをインストールします。
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Node.jsをインストールします。
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

# Yarnをインストールします。
RUN npm install -g yarn

# アプリケーションのディレクトリを作成します。
RUN mkdir /skate_puzzle_server
WORKDIR /skate_puzzle_server

# GemfileとGemfile.lockをコピーして、bundlerでインストールします。
COPY Gemfile /skate_puzzle_server/Gemfile
COPY Gemfile.lock /skate_puzzle_server/Gemfile.lock
RUN bundle install

# アプリケーションのソースコードをコピーします。
COPY . /skate_puzzle_server