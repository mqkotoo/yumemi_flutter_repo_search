import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repo_data_model.dart';
import '../../controller/controllers.dart';
import 'error/error_widget.dart';
import 'list_item.dart';
import 'list_item_shimmer.dart';

class ResultListview extends ConsumerWidget {
  const ResultListview({required this.repoData, Key? key}) : super(key: key);

  final AsyncValue<RepoDataModel> repoData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return repoData.when(
      data: (data) => data.totalCount == 0
          //検索結果がない場合
          ? const NoResultView()
          //検索結果がある場合
          //スクロールを検知して、スクロール中は検索結果数を表示しないようにする
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                  // スクロールが開始された場合の処理(非表示)
                  ref
                      .read(isResultCountVisibleProvider.notifier)
                      .update((state) => false);
                } else if (notification is ScrollEndNotification) {
                  // スクロールが終了した場合の処理(表示)
                  ref
                      .read(isResultCountVisibleProvider.notifier)
                      .update((state) => true);
                }
                return true;
              },
              child: ListView.separated(
                //スクロールでキーボードを閉じるようにした
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: data.items.length,
                itemBuilder: (context, index) => SafeArea(
                  top: false,
                  bottom: false,
                  child: ListItem(
                    repoData: data.items[index],
                    userIconUrl: data.items[index].owner.avatarUrl,
                    fullName: data.items[index].fullName,
                    description: data.items[index].description,
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xffBBBBBB),
                ),
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
    );
  }
}
