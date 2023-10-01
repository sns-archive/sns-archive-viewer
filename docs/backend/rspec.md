# RSpecの導入手順
## はじめに
- RSpecとは
  - RSpecはRubyのテストフレームワークです。
  - BDD（Behavior-Driven Development）スタイルのテストフレームワークです。
  -  BDDとはテストコードを、自然言語を用いて要求仕様のように (Spec = 仕様) 記述するための手法です。

## RSpecの導入
### 0. バックエンドの環境構築
- バックエンドの環境構築がまだの場合、progaku-archiveリポジトリのREADME.mdを読んで環境構築を行ってください。
### 1. コンテナの起動をする
- カレントディレクトリに`docker-compose.yml`ファイルがあることを確認し、ホストマシン上で以下のコマンドを実行してください。
  ```bash
  # コンテナ起動
  $ docker-compose up -d
  ```
- コンテナが起動すると以下のような表示となります。
  ```bash
  # 実行結果
  [+] Running 3/3
  - Network progaku-archive_default  Created                                                               0.0s 
  - Container pa_database            Started                                                               0.5s 
  - Container pa_backend             Started                                                               1.1s 
  ```
### 2.コンテナに入る
- ホストマシン上で以下のコマンドを実行し、pa_backendというサービス名のコンテナに入ってください。
  ```bash
  # コンテナに入る
  $ docker exec -it pa_backend bash
  ```
- コンテナに入ると以下のような表示となります。
  ```
  root@3ed6ed815f0b:/usr/src/app#
  ```
### 3.RSpecの設定をする
- コンテナ内で以下のコマンドを実行してください
  ```
  rails g rspec:install
  ```
- コマンドを実行すると、いくつかのディレクトリとファイルが生成されます。
  ```bash
  # 実行結果
  create  .rspec # 基本設定ファイル
  create  spec   # backend/spec配下にあるファイルがテストとして実行される
  create  spec/spec_helper.rb   # RSpecの全体的な設定を記述するファイル
  create  spec/rails_helper.rb  # Rails特有の設定を記述するファイル
  ```
- .rspecに以下の記述を追加してください。
  ```
  --require spec_helper
  --format documentation # 左の設定を追加する
  ```
- `--format documentation`と記述することで、テストコードの実行結果をターミナル上で表示してくれます。
