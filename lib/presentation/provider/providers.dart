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

//sortの文字列を格納
final sortStringProvider = StateProvider<String>((ref) => 'bestmatch');
