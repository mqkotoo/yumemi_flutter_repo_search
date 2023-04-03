import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/controller/controllers.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/error/error_widget.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_count.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索結果データ
    final repoData =
        ref.watch(repoDataProvider(ref.watch(inputRepoNameProvider)));
    //テキストのコントローラ
    final textController = ref.watch(textEditingControllerProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('GitHubサーチ'),
          key: const Key('searchPageAppBar'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              //search field
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
                  hintText: 'search repository',
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
            const Divider(color: Colors.black12),
            Expanded(
              flex: 8,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // result list item
                  repoData.when(
                    data: (data) => ListView.separated(
                      //スクロールでキーボードを閉じるようにした
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: data.items.length,
                      itemBuilder: (context, index) => ListItem(
                        repoData: data.items[index],
                        userIconUrl: data.items[index].owner.avatarUrl,
                        fullName: data.items[index].fullName,
                        description: data.items[index].description,
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        color: Color(0xffBBBBBB),
                      ),
                    ),
                    error: (e, _) {
                      switch (e) {
                        case 'No Keywords':
                          return const EnterTextView();
                        case 'Network Error':
                          return const NetworkErrorView();
                        case 'Error Occurred':
                          return const ErrorView();
                        default:
                          throw Exception(e);
                      }
                    },
                    loading: () => const ListItemShimmer(),
                  ),

                  // // result count
                  if (!repoData.hasError &&
                      !repoData.isLoading &&
                      repoData.value!.totalCount != 0)
                    ResultCount(resultCount: repoData.value!.totalCount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
