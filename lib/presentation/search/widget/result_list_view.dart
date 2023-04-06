import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_count.dart';
import '../../controller/controllers.dart';
import 'error/error_widget.dart';
import 'list_item.dart';
import 'list_item_shimmer.dart';

class ResultListview extends ConsumerWidget {
  const ResultListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索数
    final resultCount = ref.watch(totalCountProvider);
    return Expanded(
      flex: 8,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          resultCount.when(
            data: (totalCount) => totalCount == 0
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
                      itemCount: totalCount,
                      itemBuilder: (context, index) {
                        return ProviderScope(
                          overrides: [
                            listIndexProvider.overrideWithValue(index)
                          ],
                          child: const ListItem(),
                        );
                      },
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
          ),
          // // 検索結果がある場合は件数を表示する
          // if (ref.watch(isResultCountVisibleProvider))
          //   if (!resultCount.hasError &&
          //       !resultCount.isLoading &&
          //       resultCount.value != 0)
          //     ResultCount(resultCount: resultCount),
        ],
      ),
    );
  }
}
