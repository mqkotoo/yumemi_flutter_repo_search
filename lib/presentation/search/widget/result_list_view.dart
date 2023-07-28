import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/search_state_notifier.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/pagination_list_view.dart';

class ResultListView extends ConsumerWidget {
  const ResultListView({
    Key? key,
    required this.repoItems,
    required this.hasNext,
    this.hasNextFetchError = false,
  }) : super(key: key);

  final List<RepoDataItems> repoItems;
  final bool hasNext;
  final bool hasNextFetchError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView(
      itemCount: repoItems.length,
      hasNext: hasNext,
      fetchNext: () =>
          ref.read(searchStateNotifierProvider.notifier).fetchMore(),
      itemBuilder: (context, index) {
        return ListItem(repoItems: repoItems[index]);
      },
      hasNextFetchError: hasNextFetchError,
    );
  }
}
