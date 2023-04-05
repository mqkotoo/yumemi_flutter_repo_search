import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../controller/controllers.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({Key? key}) : super(key: key);

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
                      .update((state) => text.isNotEmpty);
                },
                //入力キーボードのdone→searchに変更
                textInputAction: TextInputAction.search,
                //search押したらデータ取得 データ渡す
                onFieldSubmitted: (text) {
                  //無駄な余白をカットしてプロバイダーに渡す
                  ref
                      .read(inputRepoNameProvider.notifier)
                      .update((state) => text.trim());
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
                                .update((state) => false);
                          },
                          key: const Key('clearButton'),
                        )
                      : const SizedBox.shrink(),
                ),
                key: const Key('inputForm'),
              ),
            ),
            //ソートボタン
            MenuAnchor(
              key: const Key('sortRadio'),
              alignmentOffset: const Offset(-120, 0),
              menuChildren: [
                RadioMenuButton(
                  value: 'bestmatch',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) => ref
                      .read(sortStringProvider.notifier)
                      .update((state) => value!),
                  child: Text('ベストマッチ'),
                ),
                RadioMenuButton(
                  value: 'updated',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) => ref
                      .read(sortStringProvider.notifier)
                      .update((state) => value!),
                  child: Text('更新日順'),
                ),
                RadioMenuButton(
                  value: 'stars',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) => ref
                      .read(sortStringProvider.notifier)
                      .update((state) => value!),
                  child: Text('スター順'),
                ),
                RadioMenuButton(
                  value: 'forks',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) => ref
                      .read(sortStringProvider.notifier)
                      .update((state) => value!),
                  child: Text('フォーク順'),
                ),
                RadioMenuButton(
                  value: 'help-wanted-issues',
                  groupValue: ref.watch(sortStringProvider),
                  onChanged: (value) => ref
                      .read(sortStringProvider.notifier)
                      .update((state) => value!),
                  child: Text('助けてイシュー順'),
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
                  key: const Key('sortButton'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
