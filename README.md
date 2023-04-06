# 株式会社ゆめみFlutterエンジニアコーディング試験課題

## スクリーンショット

| 結果一覧(light)                                                                                                                                                       | 結果一覧(dark)                                                                                                                                                        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img width="392" alt="スクリーンショット 2023-04-06 14 36 37" src="https://user-images.githubusercontent.com/87256037/230281471-c4608662-bb6e-40d7-a011-e6518ca3c195.png"> | <img width="406" alt="スクリーンショット 2023-04-06 14 36 53" src="https://user-images.githubusercontent.com/87256037/230281649-0cdbbdd4-d4e6-4ed3-81e9-33b4a675e772.png"> |

| 詳細(light)                                                                                                                                                         | 詳細(dark)                                                                                                                                                          |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img width="389" alt="スクリーンショット 2023-04-06 14 37 20" src="https://user-images.githubusercontent.com/87256037/230281754-9ba55dff-5d9a-4852-ba63-0b7f5fa14087.png"> | <img width="395" alt="スクリーンショット 2023-04-06 14 37 10" src="https://user-images.githubusercontent.com/87256037/230281761-958b9482-07f3-4d18-be6f-be261cc8fb59.png"> |

| 結果なし                                                                                                                                                              | エラー                                                                                                                                                               | 通信エラー                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img width="398" alt="スクリーンショット 2023-04-06 14 41 36" src="https://user-images.githubusercontent.com/87256037/230282678-aca243e1-7ffb-42a1-b37c-4abb983a21d5.png"> | <img width="395" alt="スクリーンショット 2023-04-06 14 44 13" src="https://user-images.githubusercontent.com/87256037/230282692-99f4ad34-755b-43a1-84d6-2bddc1286687.png"> | <img width="394" alt="スクリーンショット 2023-04-06 14 45 10" src="https://user-images.githubusercontent.com/87256037/230282722-c04f8af4-2d8a-445c-9b34-b9525c4a8714.png"> |

デモ

https://user-images.githubusercontent.com/87256037/230283897-e4477ed9-c9e9-41e5-80d4-69d04112702a.mov

### 動作

* ~何かしらのキーワードを入力できる~
* ~入力したキーワードで GitHub のリポジトリを検索できる~
* ~GitHub のリポジトリを検索する際、GitHub API（search/repositories）を利用する
  github | Dart Package のようなパッケージは利用せず、API を呼ぶ処理を自分で実装すること~
* ~検索結果は一覧で概要（リポジトリ名）を表示する~
* ~検索結果のアイテムをタップしたら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示する~

### UI/UX

* ~エラー発生時の処理~
* ~画面回転・様々な画面サイズ対応~
* ~Theme の適切な利用・ダークモードの対応~
* ~多言語対応 (英語、日本語)~

## 環境

* IDE: Android Studio Electric Eel | 2022.1.1
* Flutter: 3.7.9
* Dart: 2.19.6
* サポートするプラットフォーム
  →iOS/Android

## 状態管理

flutter_riverpod: ^2.3.2

取得するデータを扱うプロバイダーは今回FutureProviderを使用しました。
FutureProviderを使うことで、取得したデータのキャッシュ、loadingなどの操作が簡単、値が変化する時だけ再描画されるなどのメリットがあると考えました。

## 使用技術、パッケージ

* GitHub ActionsによるCI
* flutter_riverpod -状態管理
* freezed_annotation -freezedファイル生成
* http -apiの実装
* intl -言語、数字の成形
* json_annotation -jsonの変換
* shimmer -ロード画面の実装
* shared_preferences -テーマの保存
* flutter_localizations - 多言語対応
* device_preview -各サイズの画面でUIの確認
* flutter_launcher_icons -アプリアイコン

----dev----

* flutter_test -テスト
* flutter_lints -静的解析
* build_runner -ファイルの生成
* freezed -immutableなクラス作成、json変換を簡単に
* json_serializable -jsonの変換
* mockito -データをモック化してテスト
* import_sorter -importの整列
* integration_test -統合テスト

## アーキテクチャ

・[CODE WITH ANDREA](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
を主に参考にしました

＊Application層は今回ない

<img width="280" alt="スクリーンショット 2023-02-24 1 42 19" src="https://user-images.githubusercontent.com/87256037/220972746-34a0401f-962f-4717-8513-519f879ed3db.png">

### フォルダ構成

```
├── lib
│   ├── main.dart               # アプリのエントリーポイント
│   ├── domain                  # ドメイン、データのモデル定義
│   ├── constant                # 今回はアプリ内で使う色を定義
│   ├── repository              # httpでの外部とのやりとり、メソッドの定義
│   ├── generated               # 多言語ファイル生成用のディレクトリ
│   ├── l10n                    # 多言語対応
│   ├── theme                   # テーマの提供、永続化
│   └── presentation            # 見た目
│       ├── controller          # domainとpresentationの橋渡し
│       ├── detail              # 詳細ページ（widgetも含む）
│       └── search              # 検索ページ（widgetも含む）　　　　 
```

## ビルド手順

・クローン

```
git clone https://github.com/mqkotoo/github_search_study.git
```

・依存関係を読み込む（多言語対応も読み込まれます）

```
flutter pub get
```

・ビルドラン

```
flutter run
```

## テスト

### unitテスト

* データモデルの変換テスト
* データ取得メソッドのテスト
* テーマのテスト（初期状態、切り替え、テーマの記憶）

### widgetテスト

* 多言語対応のテスト
* 通信がない状態で適切にエラーハンドリングされているかのテスト
* 空文字でエラーが返るかテスト
* 通信、空文字以外のエラーがUIで正常に処理されているか（200以外のとき）
* ワード検索したら、想定の内容が表示されるか
* 画面遷移後に想定の内容が表示されるか
* ソート機能のテスト
* 検索フォームのテスト

### integrationテスト

* 検索ワードの入力、検索結果をタップすると画面遷移することを確認
* ワード検索したら、想定の内容が表示されるか
* 画面遷移後に想定の内容が表示されるか

### UIが崩れていないか（目で見て確認したところ）

* ウィジェットテストだけでなく、[device_preview](https://pub.dev/packages/device_preview)を使っていろんな画面の大きさでも画面が崩れないか
* 各画面で視認性が落ちていないか
* OSの仕様で崩れていないか
* 横画面になっても崩れないか
* 特に横画面でSafeAreaを干渉していないか
* ユーザーの端末の設定でテキストが大きくなっても画面が崩れないか
* 多言語対応に関して、タイポがないか
* 表現がおかしくないか
* 他の言語にしても画面が崩れないか

## CI

* ```develop```もしくは```main```ブランチにプルリクエストが出された時に発火する
* インポートがeffective dart推奨のように整列されてあるか
* フォーマットが崩れていないか
  →基本的には保存時に自動フォーマットしています。
* build_runnerでのファイルの生成
* 静的解析に引っかかっていないか
* テストを全て通過するか

## CD

* iOSビルド、ファイルのアップロード

## Note

* issueドリブンで開発をしました。
* プルリクエストベースで開発をして、安全に運用しました
* FutureProviderを使ってパフォーマンスを意識した
* 一回でのリストの取得数を減らして表示速度を早くした
* いろんな大きさの画面でも崩れないUIを意識しました
* 検索結果の並び替え機能をつけました
* GitHub上で見れるようにリンクを設けました
* 可読性を意識して、widgetの切り分けをしました
* コメントで読みやすいようにしました
* シンプルで使いやすい、スタイリッシュなデザインを意識しました
* ユーザーが次のアクションがわかりやすいよう、ロードをshimmerにしました（スタイリッシュでもある）
* あえて、スプラッシュ画面を入れませんでした（iPhoneのメモアプリなど、簡単にすぐ使いたいものには入れない方が良いと思う）
* 多言語対応は他のアプリに倣ってアプリ内では操作できないようにした

## 感想、難しかったところ

* アーキテクチャの理解が甘いため、もっと勉強する必要がある
* CIをつかってテストを初めてやってみたが、便利さが感じられて、品質を保証しやすいなと思った
* テストコードを初めてちゃんと書いたので、コードの書き方で不備や無駄、どこをどれくらいの粒度でテストするかなどは、まだ勉強していく必要がある。
* 1機能に1テストできるだけ書くことを意識したんですが、コードが変わってもアプリが動くことをテストできて安全に開発を進めることができることを感じたので、これからも続けていきたい。
* CDは運用の仕方もいまだによくわからなくて、生成するリリースファイルだったりがIOS,Androidのプラットフォームに詳しくないと適切に書けないと思った。