import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repo_data_model.dart';
import '../../main.dart';

//入力された文字を管理する
final inputRepoNameProvider = StateProvider<String>((ref) => '');

final textEditingControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());

final apiFamilyProvider = FutureProvider.autoDispose
    .family<RepoDataModel, String>((ref, repoName) async {

//ユーザーの入力がない場合はtotal countを-1で返してview側で処理する
  if (repoName.isEmpty) {
    return RepoDataModel.empty;
  }

  final dataRepository = ref.watch(dataRepositoryProvider);
  return await dataRepository.getData(repoName);
});