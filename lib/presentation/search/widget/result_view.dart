import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/domain/error.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/search_state_notifier.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/error/error_widget.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/pagination_list_view.dart';

class ResultView extends ConsumerWidget {
  const ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchStateNotifierProvider);
    return searchState.when(
      //初期状態
      uninitialized: () => const EnterTextView(),
      //ローディング中
      loading: () => const ListItemShimmer(),
      //成功
      success: (repositories, query, page, hasNext) => PaginationListView(
        repoItems: repositories,
        hasNext: hasNext,
        fetchNext: () =>
            ref.read(searchStateNotifierProvider.notifier).fetchMore(),
      ),
      //初期リクエスト失敗
      failure: (exception) {
        if (exception is NoTextException) {
          return const EnterTextView();
        } else if (exception is NoInternetException) {
          return const NetworkErrorView();
        } else {
          return const ErrorView();
        }
      },
      //結果が空
      empty: () => const NoResultView(),
      //追加ローディング
      fetchMoreLoading: (repositories, query, page) => PaginationListView(
        repoItems: repositories,
        hasNext: true,
        fetchNext: () =>
            ref.read(searchStateNotifierProvider.notifier).fetchMore(),
      ),
      //追加ローディングが失敗した
      fetchMoreFailure: (repositories, query, page, exception) =>
          PaginationListView(
        repoItems: repositories,
        hasNext: true,
        nextFetchError: exception,
        fetchNext: () =>
            ref.read(searchStateNotifierProvider.notifier).fetchMore(),
      ),
    );
  }
}
