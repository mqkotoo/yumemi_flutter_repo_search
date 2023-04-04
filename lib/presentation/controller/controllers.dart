import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repo_data_model.dart';
import '../../main.dart';

//入力された文字を管理する
final inputRepoNameProvider = StateProvider<String>((ref) => '');

//検索フォームのコントローラ
final textEditingControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

//検索フォームのクリアボタンの表示フラグ
final isClearButtonVisibleProvider =
    StateProvider.autoDispose<bool>((ref) => false);

//検索結果数を表示するかのフラグ（スクロール中は非表示なので基本TRUE）
final isResultCountVisibleProvider =
    StateProvider.autoDispose<bool>((ref) => true);

//データ
final repoDataProvider = FutureProvider.autoDispose
    .family<RepoDataModel, String>((ref, repoName) async {
  if (repoName.isEmpty) {
    throw 'No Keywords';
  }

  final dataRepository = ref.watch(dataRepositoryProvider);
  return await dataRepository.getData(repoName);
});
