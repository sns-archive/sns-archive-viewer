# シェルスクリプトの説明

## bin/backend/setup
イメージのビルド、development環境とtest環境のDBの作成を実行する。
初回の環境構築時に利用すると良いです。

## bin/backend/check_test_and_lint
rubocop、rspecを実行する。
プルリクエストのCIが通るか確認する際に使用すると良いです。