import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/generated/l10n.dart';
import 'package:yumemi_flutter_repo_search/presentation/provider/providers.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/notifier/search_state_notifier.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({Key? key}) : super(key: key);

  //テスト用のKEY
  @visibleForTesting
  static final inputFormKey = UniqueKey();
  @visibleForTesting
  static final clearButtonKey = UniqueKey();
  @visibleForTesting
  static final sortRadioKey = UniqueKey();
  @visibleForTesting
  static final sortButtonKey = UniqueKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //テキストのコントローラ
    final textController = ref.watch(textEditingControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //search field
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          children: [
            //検索フォーム
            Expanded(
              child: TextFormField(
                controller: textController,
                onChanged: (text) {
                  ref
                      .read(isClearButtonVisibleProvider.notifier)
                      .update((_) => text.isNotEmpty);
                },
                //入力キーボードのdone→searchに変更
                textInputAction: TextInputAction.search,
                //search押したらデータ取得 データ渡す
                onFieldSubmitted: (text) {
                  ref
                      .read(searchStateNotifierProvider.notifier)
                      .searchRepositories(
                          text.trim(), ref.watch(sortStringProvider));
                  //再検索用に文字列を持っておく
                  ref
                      .read(inputRepoNameProvider.notifier)
                      .update((_) => text.trim());
                },
                //decoration
                decoration: InputDecoration(
                  hintText: S.of(context).formHintText,
                  prefixIcon: const Icon(Icons.search, size: 27),
                  suffixIcon: ref.watch(isClearButtonVisibleProvider)
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 27),
                          onPressed: () {
                            textController.clear();
                            ref
                                .watch(isClearButtonVisibleProvider.notifier)
                                .update((_) => false);
                          },
                          key: clearButtonKey,
                        )
                      : const SizedBox.shrink(),
                ),
                key: inputFormKey,
              ),
            ),
            //ソートボタン
            MenuAnchor(
              key: sortRadioKey,
              alignmentOffset: const Offset(-120, 0),
              menuChildren: [
                RadioMenuButton(
                  value: 'bestmatch',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) {
                    changeSortStringAndSearch(
                      ref: ref,
                      sortString: value,
                      searchQuery: textController.text.trim(),
                    );
                  },
                  child: Text(S.of(context).bestMatch),
                ),
                RadioMenuButton(
                  value: 'updated',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) {
                    changeSortStringAndSearch(
                      ref: ref,
                      sortString: value,
                      searchQuery: textController.text.trim(),
                    );
                  },
                  child: Text(S.of(context).updated),
                ),
                RadioMenuButton(
                  value: 'stars',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) {
                    changeSortStringAndSearch(
                      ref: ref,
                      sortString: value,
                      searchQuery: textController.text.trim(),
                    );
                  },
                  child: Text(S.of(context).stars),
                ),
                RadioMenuButton(
                  value: 'forks',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) {
                    changeSortStringAndSearch(
                      ref: ref,
                      sortString: value,
                      searchQuery: textController.text.trim(),
                    );
                  },
                  child: Text(S.of(context).forks),
                ),
                RadioMenuButton(
                  value: 'help-wanted-issues',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) {
                    changeSortStringAndSearch(
                      ref: ref,
                      sortString: value,
                      searchQuery: textController.text.trim(),
                    );
                  },
                  child: Text(S.of(context).helpWantedIssue),
                ),
              ],
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.sort, size: 32),
                  key: sortButtonKey,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void changeSortStringAndSearch(
      {required WidgetRef ref,
      required String? sortString,
      required String searchQuery}) {
    ref
        .read(searchStateNotifierProvider.notifier)
        .searchRepositories(searchQuery.trim(), sortString!);
    ref.read(sortStringProvider.notifier).state = sortString;
  }
}
