import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../controller/controllers.dart';

class SearchField extends ConsumerWidget {
  const SearchField({Key? key}) : super(key: key);

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
    );
  }
}
