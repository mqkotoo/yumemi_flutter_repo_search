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
        ref.watch(apiFamilyProvider(ref.watch(inputRepoNameProvider)));
    //テキストのコントローラ
    final textController = ref.watch(textEditingControllerProvider);

    return Scaffold(
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
              //入力キーボードのdone→searchに変更
              textInputAction: TextInputAction.search,
              //search押したらデータ取得 データ渡す
              onFieldSubmitted: (text) => ref
                  .read(inputRepoNameProvider.notifier)
                  .update((state) => text),
            ),
          ),
          const Divider(color: Colors.black12),
          Expanded(
            flex: 8,
            child: repoData.when(
              data: (data) => data.totalCount == -1
                  ? const Center(child: Text('enter text'))
                  : ListView.separated(
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
                                    builder: (context) => DetailPage(
                                        repoData: data.items[index])),
                              );
                            },
                          ),
                      separatorBuilder: (context, index) => const Divider(
                            color: Color(0xffBBBBBB),
                          )),
              error: (error, stack) => Text(error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
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
