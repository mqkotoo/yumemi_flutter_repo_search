import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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

//sortの文字列を格納
final sortStringProvider = StateProvider<String>((ref) => 'bestmatch');
