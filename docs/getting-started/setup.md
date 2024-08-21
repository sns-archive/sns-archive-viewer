# 環境構築
初回の環境構築方法についての説明

## 1. リポジトリをクローンする
まずはリポジトリをクローンします。

```bash
git clone git@github.com:ochi-sho-private-study/slack-archive.git
```

クローンできたか確認するために、以下のコマンドを実行します。

```bash
ls
# slack-archiveが存在することを確認
```

次に、`slack-archive` のディレクトリに移動します。

```bash
cd slack-archive/
```

再度 `ls` コマンドを実行し、以下のファイルやディレクトリが表示されていれば移動できています。

```bash
ls
# README.md, backend, bin, docker-compose.yml, docs, infra が表示される
```

ここがルートディレクトリになります。

## 2. データベースのenvファイルを作成する

Dockerのコンテナを起動する前に、データベース接続に必要な情報を含む環境変数の設定ファイルを作成する必要があります。`docker-compose.yml` の `env_file` に指定された場所で読み込まれます。

```yaml
env_file:
  - ./infra/env/backend.env
```

`infra/env/` 配下にある `backend.env` を作成します。

### envディレクトリに移動

```bash
cd infra/env/
```

### backend.envファイルを作成

```bash
touch backend.env
```

同ディレクトリに「backend.env.template」というテンプレートファイルがあるのでこれを元に作成します。

#### backend.env.template の内容

```plaintext
DATABASE_URL=mysql2://root:root@db/app_development
DATABASE_TEST_URL=mysql2://root:root@db/app_test
```

### backend.env の作成方法

`backend.env.template` の内容を `backend.env` にコピーします。

```bash
cp backend.env.template backend.env
```

backend.env ファイルの内容は以下のようになります。

```plaintext
DATABASE_URL=mysql2://root:root@db/app_development
DATABASE_TEST_URL=mysql2://root:root@db/app_test
```

この設定ファイルの意味は以下の通りです。

```plaintext
DATABASE_URL=mysql2://root:root@db/app_development
# [環境変数の名前]=[sqlのドライバ名]://[ユーザ名]:[パスワード]@[ホスト名(コンテナ名)]/データベース名
```

これは `backend/config/database.yml` の環境変数になります。Railsからデータベースに接続する際に必要です。

```yaml
development:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>

test:
  <<: *default
  url: <%= ENV['DATABASE_TEST_URL'] %>
```

## 3. イメージをビルドし、データベースを作成

ルートディレクトリに移動して以下のコマンドを実行します。

```bash
bin/backend/setup
```

以下のログが出力されていればOKです。

```plaintext
 ✔ Network slack-archive_default   Created
 ✔ Volume "slack-archive_db-data"  Created
 ✔ Container pa_database             Created
```

データベースの作成が成功すると、次のメッセージが表示されます。

```plaintext
Created database 'app_development'
Created database 'app_test'
```

次に、スキーマファイルを使用してテーブルを作成します。以下のコマンドを実行します。

```bash
docker compose run backend rake ridgepole:apply
```
テーブルの作成が成功すると以下のような出力が表示されます。

```plaintext
-- create_table("users", {:charset=>"utf8mb4", :collation=>"utf8mb4_0900_ai_ci"})
   -> 0.0457s
-- create_table("memos", {:charset=>"utf8mb4", :collation=>"utf8mb4_0900_ai_ci"})
   -> 0.0152s
-- create_table("comments", {:charset=>"utf8mb4", :collation=>"utf8mb4_0900_ai_ci"})
   -> 0.0149s
-- add_index("comments", ["memo_id"], {:name=>"index_comments_on_memo_id"})
   -> 0.0874s
```

## 4. コンテナを起動

以下のコマンドでコンテナを起動します。

```bash
docker compose up -d
```

コンテナが正常に起動していることを確認します。

```plaintext
[+] Running 2/2
 ✔ Container pa_database  Healthy
 ✔ Container pa_backend   Started
```

さらに、`docker compose ps` コマンドで再度確認します。

```bash
docker compose ps
# 出力結果:
# NAME          IMAGE                     COMMAND                                               SERVICE   CREATED          STATUS                   PORTS
# pa_backend    slack-archive-backend   "sh -c 'rm -f tmp/pids/server.pid && bundle exec …"   backend   26 seconds ago   Up 25 seconds            0.0.0.0:3000->3000/tcp
# pa_database   mysql:8.0                 "docker-entrypoint.sh mysqld"                         db        6 minutes ago    Up 6 minutes (healthy)   0.0.0.0:3306->3306/tcp, 33060/tcp
```

データベースとバックエンドの両方のコンテナが起動していることを確認します。

## 5. 確認

ブラウザで `localhost:3000` を入力し、Railsのウェルカムページが表示されれば環境構築は成功です。
