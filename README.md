# 株式会社ゆめみFlutterエンジニアコーディング試験課題

## スクリーンショット

| 結果一覧(light)                                                                                                                                                       | 結果一覧(dark)                                                                                                                                                        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img width="390" alt="スクリーンショット 2023-07-27 9 29 34" src="https://github.com/mqkotoo/yumemi_flutter_repo_search/assets/87256037/6b62df68-1924-4c7f-a804-33964fbd2928"> | <img width="390" alt="スクリーンショット 2023-07-27 9 29 51" src="https://github.com/mqkotoo/yumemi_flutter_repo_search/assets/87256037/3f9f5468-1ef8-4153-b54d-26c29e1228f6"> |

| 詳細(light)                                                                                                                                                         | 詳細(dark)                                                                                                                                                          |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img width="390" alt="スクリーンショット 2023-04-06 14 37 20" src="https://user-images.githubusercontent.com/87256037/230281754-9ba55dff-5d9a-4852-ba63-0b7f5fa14087.png"> | <img width="390" alt="スクリーンショット 2023-04-06 14 37 10" src="https://user-images.githubusercontent.com/87256037/230281761-958b9482-07f3-4d18-be6f-be261cc8fb59.png"> |

| 結果なし                                                                                                                                                              | エラー                                                                                                                                                               | 通信エラー                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img width="350" alt="スクリーンショット 2023-04-06 14 41 36" src="https://user-images.githubusercontent.com/87256037/230282678-aca243e1-7ffb-42a1-b37c-4abb983a21d5.png"> | <img width="350" alt="スクリーンショット 2023-07-27 11 34 32" src="https://github.com/mqkotoo/yumemi_flutter_repo_search/assets/87256037/60a59a44-42d2-4ec4-b9bf-aea6b6dd66ab"> | <img width="350" alt="スクリーンショット 2023-07-27 11 34 54" src="https://github.com/mqkotoo/yumemi_flutter_repo_search/assets/87256037/17bf8dc0-066c-4d82-a325-8472ad1906b2"> |

デモ

https://github.com/mqkotoo/yumemi_flutter_repo_search/assets/87256037/52950ebb-4793-4f4b-8af6-b26018902bb2



### 動作

* 何かしらのキーワードを入力できる
* 入力したキーワードで GitHub のリポジトリを検索できる
* 検索結果は一覧で概要（リポジトリ名）を表示する
* 検索結果のアイテムをタップしたら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue
  数）を表示する

### UI/UX

* エラー発生時の処理
* 画面回転・様々な画面サイズ対応
* Theme の適切な利用・ダークモードの対応
* 多言語対応 (英語、日本語)
* 検索結果の並び替え

## 環境

* IDE: Android Studio Electric Eel | 2022.1.1
* Flutter: 3.7.9
* Dart: 2.19.6
* サポートするプラットフォーム
  →iOS/Android

## 状態管理

flutter_riverpod: ^2.3.2

## 使用技術、パッケージ

* GitHub ActionsによるCI
* flutter_riverpod -状態管理
* freezed_annotation -freezedファイル生成
* http -apiの実装
* intl -言語、数字の成形
* json_annotation -jsonの変換
* shimmer -ロード画面の実装
* shared_preferences -テーマの保存
* flutter_localizations -多言語対応
* device_preview -各サイズの画面でUIの確認
* flutter_launcher_icons -アプリアイコン
* visibility_detector -レンダリングを感知、ページングに使用

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
│   ├── provider                # 状態を管理
│   ├── presentation            # 見た目
│       ├── detail              # 詳細ページ（widgetも含む）
│       └── search              # 検索ページ（widgetも含む）

```

## ビルド手順

・クローン

```
git clone https://github.com/mqkotoo/github_search_study.git
```

・fvm読み込み

 ```
 fvm install
 ```

・依存関係を読み込む（多言語対応も読み込まれます）

```
fvm flutter pub get
```

・freezed等のコード生成

```
fvm flutter pub run build_runner build -d
```

・ビルドラン

```
fvm flutter run
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
* 通信、空文字以外のエラーがUIで正常に処理されているか（今回の場合はリクエスト過多が基本）
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
* テストコードを初めてちゃんと書いたので、コードの書き方で不備や無駄、どこをどれくらいの粒度でテストするかなどは、まだ勉強していく必要がある
* 1機能に1テストできるだけ書くことを意識したんですが、コードが変わってもアプリが動くことをテストできて安全に開発を進めることができることを感じたので、これからも続けていきたいとおもった

## 帰属表示

アニメーションには[LottieFiles](https://lottiefiles.com/)を使用しました。

使用させていただいた、アニメーションは以下です。

* https://lottiefiles.com/animations/guy-typing-gQBdgWO7Yp
* https://lottiefiles.com/animations/error-IIYA1ND2nr
* https://lottiefiles.com/animations/shake-a-empty-box-LbpTzQkY00
* https://lottiefiles.com/animations/no-internet-Ozj1wsbKIw
