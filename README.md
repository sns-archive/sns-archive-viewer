# progaku-archive
Progakuのアーカイブ用のアプリ

## バックエンドの環境構築
### 1. envファイルを作成して記述する
`infra/env/backend.env`を作成して、`infra/env/backend.env.template`の内容を元に記述する。

**※ 現時点ではコピペでも動きますが、usernameやpasswordは適宜変えて使用して下さい。**

---

残りのコマンドの実行は、`bin/backend/setup`コマンドを実行しても同じ結果が得られます。
### 2. imageをbuildする
以下のコマンドをホストマシン上で実行して下さい。
```
$ docker compose build backend
```

### 3. MySQLコンテナにローカル用のdatabaseを作成する
以下のコマンドをホストマシン上で実行して下さい。
```bash
$ docker compose run backend rails db:create
$ docker compose run backend rails db:create RAILS_ENV=test
```

### 4. マイグレーションを行う
以下のコマンドをホストマシン上で実行して下さい。
```bash
$ docker compose run backend rake ridgepole:apply
```
