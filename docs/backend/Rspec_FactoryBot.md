# RSpecとFactoryBotの導入
## はじめに
- バックエンドの環境構築がまだの場合progaku-archiveリポジトリのREADME.mdを読み、バックエンドの環境構築を行ってください。
- **RSpecとは** 
  - RSpecはRubyのテストフレームワークです。
- **FactoryBotとは**
  - サンプルデータ（ダミーのインスタンス）を簡単に作成することができるテストツールです。

## RSpecの導入手順
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

### 2. コンテナに入る
- ホストマシン上で以下のコマンドを実行し、pa_backendというサービス名のコンテナに入ってください。
  ```bash
  # コンテナに入る
  $ docker exec -it pa_backend bash
  ```
- コンテナに入ると以下のような表示となります。
  ```
  root@3ed6ed815f0b:/usr/src/app#
  ```

### 3. RSpecの設定をする
- pa_backendコンテナ内で以下のコマンドを実行してください
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

## FactoryBotの導入手順
### 1. FactoryBotのコードを簡潔に書けるようにする
- `backend/spec/rails_helper.rb`に以下の設定を追記してください。
  ```ruby
  RSpec.configure do |config|
    # 下記を追記
    config.include FactoryBot::Syntax::Methods

    # 以下省略
  end
  ```
- 上記の設定をすることでRSpecを書く際に、`FactoryBot.create(:hoge)`や`FactoryBot.build(:hoge)`の`FactoryBot`を省略できるようになります。

### 2. FactoryBot用のディレクトリを生成する
- `backend/spec/`直下に`factory`ディレクトリを作成してください。
- 上記で作成した`factory`ディレクトリ内に`users.rb`というファイルを作成し、以下の内容を記述してください。
  ```ruby
  # frozen_string_literal: true

  FactoryBot.define do
    factory :user do
      name { 'hogehoge' }
      email { 'hogehoge@example.com' }
    end
  end
  ```

## RSpecとFactoryBotの動作確認
### 1. テストコードを準備する
- `backend/spec/`直下に`models`ディレクトリを作成してください。
- 上記で作成した`models`ディレクトリ内に`user_spec.rb`というファイルを作成し、以下の内容を記述してください。
  ```ruby
  require 'rails_helper'

  RSpec.describe User, type: :model do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
  ```

### 2. テストを実行する
- pa_backendコンテナ内で以下のコマンドを実行してください。
  ```bash
  # テストを実行
  bundle exec rspec spec/models/user_spec.rb
  ```
- テストに成功し、以下のような表示が出れば動作確認完了です！
  ```bash
  # 実行結果
  User
  is valid with valid attributes

  Finished in 0.07038 seconds (files took 3.77 seconds to load)
  1 example, 0 failures
  ```
