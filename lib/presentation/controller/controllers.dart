import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/domain/error.dart';
import '../../domain/repo_data_model.dart';
import '../../main.dart';

//入力された文字を管理する
final inputRepoNameProvider = StateProvider<String>((ref) => '');

//検索フォームのコントローラ
final textEditingControllerProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

//検索フォームのクリアボタンの表示フラグ
final isClearButtonVisibleProvider =
    StateProvider.autoDispose<bool>((ref) => false);

//検索結果数を表示するかのフラグ（スクロール中は非表示なので基本TRUE）
final isResultCountVisibleProvider =
    StateProvider.autoDispose<bool>((ref) => true);

//エラー時のリロードボタンを表示するかのフラグ
final isReloadButtonVisibleProvider = StateProvider<bool>((ref) => false);

//sortの文字列を格納
final sortStringProvider = StateProvider<String>((ref) => 'bestmatch');

//以下のページネーション参考
// https://itnext.io/seamless-infinite-list-with-riverpod-in-flutter-15369f3c9cd2

//ページごとのデータ取得
final paginatedResultProvider =
    FutureProvider.family<RepoDataModel, int>((ref, page) async {
  //sort
  final sortString = ref.watch(sortStringProvider);
  //inputText
  final inputText = ref.watch(inputRepoNameProvider);

  //未入力だったらリクエスト投げる前にエラーを投げる
  if (inputText.isEmpty) {
    throw NoTextException();
  }

  final dataRepository = ref.watch(dataRepositoryProvider);
  return await dataRepository.getData(
      repoName: inputText, sort: sortString, page: page + 1);
});

//全部の結果数を管理する
final totalCountProvider = Provider<AsyncValue<int>>(
  (ref) => ref.watch(paginatedResultProvider(0)).whenData((e) => e.totalCount),
  dependencies: [paginatedResultProvider],
);

//上で取得したindexを使ってページ、要素の判定
final repoAtIndexProvider = Provider.family<AsyncValue<RepoDataItems>, int>(
  (ref, index) {
    //取得するデータのper_pageは20
    final page = index ~/ 20;
    final indexOnPage = index % 20;

    final res = ref.watch(paginatedResultProvider(page));
    return res.whenData((e) => e.items[indexOnPage]);
  },
  dependencies: [paginatedResultProvider],
);
