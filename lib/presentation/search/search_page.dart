import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/search_state_notifier.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/error/error_widget.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_list_view.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_app_bar.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_bar.dart';
import '../../domain/error.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchStateNotifierProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const SearchAppBar(),
        body: Column(
          children: <Widget>[
            //検索フォーム
            const SearchBar(),
            const Divider(),
            //検索結果のリスト表示部分
            Expanded(
              flex: 8,
              child: searchState.when(
                uninitialized: () => const EnterTextView(),
                loading: () => const ListItemShimmer(),
                success: (repositories, query, page, hasNext) {
                  return ResultListView(
                    repoItems: repositories,
                    hasNext: hasNext,
                  );
                },
                failure: (exception) {
                  if (exception is NoTextException) {
                    return const EnterTextView();
                  } else if (exception is NoInternetException) {
                    return const NetworkErrorView();
                  } else {
                    return const ErrorView();
                  }
                },
                empty: () => const NoResultView(),
                fetchMoreLoading: (repositories, query, page) => ResultListView(
                  repoItems: repositories,
                  hasNext: true,
                ),
                fetchMoreFailure: (repositories, query, page, exception) =>
                    ResultListView(
                  repoItems: repositories,
                  hasNext: true,
                  hasNextFetchError: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
