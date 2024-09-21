# Biomeの使い方

## Biomeとは

JavaScript/TypeScript プロジェクト向けの開発ツール

フォーマット、リンティング、インポートの整理など、コードの品質と一貫性を保つための機能を提供する

- **フォーマッター (Formatter)**: コードのスタイルを自動的に整える
- **リンター (Linter)**: コードの構文やスタイルの問題を指摘する
- **インポートの整理 (Organize Imports)**: 不要なインポートを削除し、インポート順序を整理する

## 使い方

### Formatter

Formatのルールに違反している箇所を指摘する

```bash
$ yarn biome format <ディレクトリ名、ファイル名>
```

Formatを適用する

```bash
$ yarn biome format --write <ディレクトリ名、ファイル名>
```

より詳しい情報は下記のドキュメントを参照してください。

https://biomejs.dev/ja/formatter/

### Linter

Lintのルールに違反している箇所を指摘する

```bash
$ yarn biome check <ディレクトリ名、ファイル名>
```

Lintのルールに沿って安全な修正をする

```bash
$ yarn biome check --write <ディレクトリ名、ファイル名>
```

より詳しい情報は下記のドキュメントを参照してください。

https://biomejs.dev/ja/linter/
