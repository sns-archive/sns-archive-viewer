# RSpecとFactoryBot
## 目次
- [RSpecとFactoryBotの動作確認](#rspecとfactorybotの動作確認)
- [RSpecについて](#rspecについて)
- [FactoryBotについて](#factorybotについて)
- [参考記事](#参考記事)

## RSpecとFactoryBotの動作確認
### 0. はじめに
- バックエンドの環境構築がまだの場合slack-archiveリポジトリのREADME.mdを読み、バックエンドの環境構築を行ってください。

### 1. コンテナに入る
- ホストマシン上で以下のコマンドを実行し、pa_backendというサービス名のコンテナに入ってください。
  ```bash
  # コンテナに入る
  $ docker exec -it pa_backend bash
  ```
- コンテナに入ると以下のような表示となります。
  ```
  root@3ed6ed815f0b:/usr/src/app#
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

## RSpecについて
### 1. 概要
#### RSpecとは
- RSpecはRuby on Railsの開発でよく使われているテストフレームワーク
- rubyに標準搭載されているminitestよりも様々な機能が使えて便利！

### 2. 基本的な構文
```ruby
describe 'テスト対象のクラス名やメソッド名' do
  context '条件や状態の説明' do
    before do
      # 事前準備
    end

    it '期待する動作の説明' do
      # 期待動作
      expect(実際の値).to eq 期待する値
    end
  end
end
```
#### describe
- テスト対象の機能を記述する
- Model Specではクラス名やメソッド名を記述する
- System Specでは一連の操作により動作確認したい機能や処理の名前を記述する
#### context
- テストの様々な条件の概要を記述する。
- 例：〇〇の戻り値が△△のとき
#### before
- descreibeの中に複数のテストケースがある場合、事前処理をまとめて記述しておく
- breforeブロック内の処理はitブロックの処理が実行されるたびに実行される
#### it
- 期待する動作の詳細や条件などの具体的なテストコードを記述する
- itブロック内の記述が実行され、テストに成功すれば成功件数が1件カウントされる
- 例外が発生した場合は`Error`、例外は起きていないがテストに失敗した場合は`Failure`にカウントされる

### 3. テストの実行方法
#### 特定のファイルのみ実行する
```bash
# bundle exec rspec [ファイルパス]
bundle exec rspec spec/system/users_spec.rb
```
#### 特定の行のみテストを実行する
```bash
# bundle exec rspec [ファイルパス]:[行数]
bundle exec rspec spec/system/users_spec.rb:10
```

## FactoryBotについて
### 1. 概要
#### FactoryBotとは
- Rubyのオブジェクトを簡単な構文で生成することができるgem
- RSpecと組み合わせて使うことで、テストで使用するデータを簡単に作成することができる！

### 2. factoryの定義方法
`spec/factories`ディレクトリに以下のようなテストデータ生成用のファイルを作成する
  ```ruby
  # Userクラスのオブジェクトを想定
  FactoryBot.define do
    factory :user do
      email { 'hogehoge@example.com' }
      password { 'sample_password' }
    end
  end
  ```
### 3. テスト内でテストデータを作成する方法
#### buildメソッド
- factoyで定義されたモデルオブジェクトのインスタンスを生成する
- DBにレコードは**追加されない**
  ```ruby
  ＜使用例＞
  FactoryBot.build(:user)
  # FactoryBotは省略可
  build(:user)
  ```

#### createメソッド
- factoryで定義されたモデルオブジェクトのインスタンスを生成する
- DBにレコードを**追加する**
  ```ruby
  ＜使用例＞
  FactoryBot.create(:user)
  # FactoryBotは省略可
  create(:user)
  ```
#### メソッドの前に付けるFactoryBotの記述を省略する
- `rails_helper.rb`に以下の設定を追加することで、factory_botメソッドの前に`FactoryBot`を付ける必要がなくなる
- 今回準備した環境では既に設定済み
  ```ruby
  RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
  end
  ```

## 参考記事
#### RSpec関連
- https://qiita.com/jnchito/items/42193d066bd61c740612
- https://qiita.com/awakia/items/2d9a70af86bc3488b241
#### actoryBot関連
- https://qiita.com/andmorefine/items/a51fda98a0baeb4b89fa
- https://qiita.com/kodai_0122/items/e755a128f1dade3f53c6
