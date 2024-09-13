# 環境構築
初回の環境構築方法についての説明

## 1. 依存関係のインストール

package.json ファイルを参照し、その中で定義された依存関係（ライブラリやモジュール）を node_modules ディレクトリにインストールします。

以下のコマンドを実行してください。


```bash
$ docker compose run frontend yarn install
$ docker compose up -d
```

ブラウザで `http://localhost:4000` を入力し、Next.jsのトップページが表示されれば環境構築は成功です。
