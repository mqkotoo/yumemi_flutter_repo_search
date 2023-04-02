import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/controller/controllers.dart';

import '../detail/detail_page.dart';

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
        appBar: AppBar(
          title: const Text('GitHubサーチ'),
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
                          })
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            const Divider(color: Colors.black12),
            Expanded(
              flex: 8,
              child: repoData.when(
                data: (data) => ListView.separated(
                    //スクロールでキーボードを閉じるようにした
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: data.items.length,
                    itemBuilder: (context, index) => _listItem(
                          fullName: data.items[index].fullName,
                          description: data.items[index].description,
                          imageSource: data.items[index].owner.avatarUrl,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(repoData: data.items[index])),
                            );
                          },
                        ),
                    separatorBuilder: (context, index) => const Divider(
                          color: Color(0xffBBBBBB),
                        )),
                error: (error, stack) => Center(child: Text(error.toString())),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItem(
      {required String fullName,
      String? description,
      required String imageSource,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(width: 16),
          ClipOval(
            child: Image.network(
              width: 60,
              height: 60,
              imageSource,
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                fullName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                description ?? 'No Description',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
