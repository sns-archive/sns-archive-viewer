# DB関連の説明
## 使用しているRDBMS
MySQL8.0

## マイグレーション方法
- Ridgepoleというgemを使用しています。
  - https://github.com/ridgepole/ridgepole

## Schemafileの記述方法
使用方法をざっくり以下にまとめます。

### 1. `db/Schemafile`にSchemaの変更内容を記述する
logsテーブルを作成したい場合は、以下のように記述します。
(詳しくは本家のREADMEを参照して下さい。)
```ruby
create_table 'logs', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
  t.string 'title', null: false
  t.string 'content', null: false, comment: 'ログの内容'
  t.integer 'log_type', null: false, comment: 'ログタイプ(ENUM)'
  t.timestamp 'created_at', null: false
  t.timestamp 'updated_at', null: false

  t.index %w[title log_type], unique: true # 複合ユニーク制約を付与
  t.index %w[title] # インデックスを付与
end
```

既存のテーブルのカラムを変更したい場合は、すでに記述された内容を変更します。
（以下の例は、emailカラムからemail_addressカラムに、カラム名を変更し、nullableにする例です。）
```diff
create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
-  t.string 'email', null: false, comment: 'ユーザーのEmailアドレス'
+  t.string 'email', null: true, comment: 'ユーザーのEmailアドレス', renamed_from: 'email_address'
  t.string 'password', null: false, comment: 'ユーザーのpassword'
  t.timestamp 'created_at', null: false
  t.timestamp 'updated_at', null: false
end
```

### 2. ridgepoleコマンドを実行する
以下のコマンドを実行します。
```bash
$ docker compose run backend rake ridgepole:apply
```
実行してからDBにアクセスすると、Schemaが変更されていることがわかるかと思います！ :tada:
