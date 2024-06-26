# 開発フロー(backend)
**※参考までにコマンド記載してますが、Gitの操作は、各自自身の使いやすいツールで行ってもらって大丈夫です**


## ブランチの作成
issueにassignしたらまずブランチを作成します。

1. mainブランチに切り替え
```bash
$ git switch main
```

2. mainブランチを最新の状態にします。
```bash
$ git pull origin main
```

3. mainブランチからブランチを作成
```bash
$ git switch -c [ブランチ名]
```

### ブランチの命名
```
[カテゴリ]/#[issue番号]-[ブランチ名]
```
#### カテゴリの種類
| ブランチの種類 | 説明                           |
| ------------- | ------------------------------ |
| feature       | 新しい機能の開発                |
| bugfix        | バグや不具合の修正              |
| docs          | ドキュメントの追加や修正        |
| refactor      | コードのリファクタリング         |
| test          | テストの追加や修正               |
| enhance       | 機能の改善や強化                 |

**例1**：機能追加でメモ作成のAPIを作成する場合
```
feature/#40-create-memos-api
```

**例2**：開発フローのドキュメントを作成する場合
```
docs/#46-dev-flow-docs
```

## マイルストーンを設定する
ブランチを作成したら、マイルストーンを設定しましょう。
> マイルストーンとは？
 マイルストーンとは、プロジェクト管理における重要な節目や目標のこと。プロジェクトの進行状況等を完了を確認するために設定される

GitHubのマイルストーンについては[こちら](https://docs.github.com/ja/issues/using-labels-and-milestones-to-track-work/filtering-issues-and-pull-requests-by-milestone)を参照してください

上記のマイルストーンの機能を使用し、自身で作業の見積もりを立てていただき、期限日の設定をし、issueに紐付けてください。
以下の方法でも作成することができます。

issueの右側にあるMilestoneという項目をクリック ⇨ 表示されるテキストボックスにMilestone名を入力　⇨「Create and assign to new milestone」をクリック ⇨ Milestoneに作成したMilestoneが表示されるのでクリック→ 作成したMilestoneにチェックを入れて「Edit Milestone」をクリック→ 期日を設定し保存

## タスクに取り組む
マイルストーンを設定したら、issueの内容を元にタスクに取り組みます。
不明点あればissueのコメント欄に記載してください。

## テストを実施
タスクを終えて動作確認ができたら、次はテストです。バックエンドでは、プルリクエストを出すと自動でCIが動き、rubocop と rspec が実行されます。これらのテストにパスしないとプルリクエストは通らないので、まずはローカルでテストを実行して確認しておきましょう。
実行方法については以下を参照してください。
[Rspecについて](../backend/Rspec_FactoryBot.md)
[rubocopについて](../backend/rubocop.md)

尚以下のスクリプトを実行することで、Rspec、rubocopどちらも実行し、確認することができます。

```bash
$ bin/backend/check_test_and_lint
```

## commitを行う
動作確認ができたらコミットを行います。

基本的なコミットの流れは以下の通りです。
### 1. ステージングに乗せる
```bash
$ git add [対象のファイル]
```
**例:今作成している、ドキュメントファイルをステージングに乗せる場合**
```bash
$ git add docs/getting-started/team_dev_flow.md
```

### 2. コミットする
```bash
$ git commit -m [コミットメッセージ]
```

### 補足
今、何のファイルに変更が加わっているのか、ステージングに乗っているファイルは何か等、現在の状態は以下のコマンドで確認できます
```bash
$ git status
```

例えば以下のような情報を教えてくれます
```bash
$ git status
On branch docs/#46-dev-flow-docs   ⇦  現在のブランチ名
Your branch is ahead of 'origin/docs/#46-dev-flow-docs' by 1 commit.
  (use "git push" to publish your local commits) ⇦ リモートのブランチより1つコミットが進んでいる

Changes not staged for commit:  ⇦ 変更がステージングされてない
  (use "git add <file>..." to update what will be committed) ⇦ステージングに乗せる方法
  (use "git restore <file>..." to discard changes in working directory) ⇦変更を破棄する方法
	modified:   docs/getting-started/team_dev_flow.md. ⇦  変更したファイル名
```

## pushを行う

タスクの実装とテストが完了したら、リモートリポジトリに変更をプッシュします。以下の手順に従ってプッシュを行ってください。

### 1. 変更内容のステージング
まず、作業ディレクトリ内の変更をステージングします。
```bash
$ git add [ファイル名]
```

### 2. 変更内容のコミット
次に、ステージングされた変更をコミットします。コミットメッセージには、変更内容がわかるように記述してください。
```bash
$ git commit -m "コミットメッセージ"
```

### 3. リモートリポジトリにプッシュ
最後に、リモートリポジトリにプッシュします。

```bash
$ git push origin [ブランチ名]
```

## プルリクエストを作成

リモートリポジトリにプッシュした後、GitHubでプルリクエストを作成します。テンプレート文が表示されるので以下の内容で記載してください。

1. **タイトル**：ブランチ名と同じか、変更内容がわかるもの。
2. **対応するissue**：関連するissue番号をテンプレートのcloseの箇所に書きます
3. **対応内容**：変更の概要、実装した機能や修正内容などを書きます。

プルリクエストを作成したら、レビュアーにレビューを依頼してください。
**レビュアー**
とくゆーさん
おっちーさん
プルリクエストのURLと共に、slackでメンション付きで依頼します。

## コードレビュー

レビュアーから指摘があれば、内容に応じて修正を行います。修正が終わったら再度レビュー依頼をしてください。

## マージ

レビュアーからOKをもらったら、プルリクエストをmainブランチにマージしてもらいます。
最後に、マージした内容をローカルのメインブランチに反映します。

メインブランチに切り替え
```bash
$ git switch main
```

ローカルにpull
```bash
$ git pull origin main
```

以上になります。