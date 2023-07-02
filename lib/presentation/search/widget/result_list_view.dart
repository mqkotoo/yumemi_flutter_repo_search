import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:yumemi_flutter_repo_search/domain/error.dart';
import '../../../constants/app_color.dart';
import '../../../generated/l10n.dart';
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
              if (e is NoTextException) {
                return const EnterTextView();
              } else if (e is NoInternetException) {
                return const NetworkErrorView();
              } else {
                return const ErrorView();
              }
            },
            loading: () => const ListItemShimmer(),
          ),
          // 検索結果がある場合は件数を表示する
          if (ref.watch(isResultCountVisibleProvider))
            if (!resultCount.hasError &&
                !resultCount.isLoading &&
                resultCount.value != 0)
              _resultCount(context, resultCount),
        ],
      ),
    );
  }

  //結果のカウント表示
  Widget _resultCount(BuildContext context, AsyncValue<int> resultCount) {
    //横画面の場合ノッチに隠れないようにする
    return Positioned(
      bottom: 30,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColor.lightBgColor
              : AppColor.darkBgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '${NumberFormat('#,##0').format(resultCount.value)}${S.of(context).result}',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColor.lightCountColor
                : AppColor.darkCountColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          key: const Key('resultCount'),
        ),
      ),
    );
  }
}
