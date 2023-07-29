import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/domain/error.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/search_state_notifier.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/pagination_loading.dart';

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';

class PaginationListView extends ConsumerWidget {
  const PaginationListView({
    Key? key,
    required this.repoItems,
    required this.hasNext,
    required this.fetchNext,
    this.hasNextFetchError = false,
  }) : super(key: key);

  final List<RepoDataItems> repoItems;
  final bool hasNext;
  final void Function() fetchNext;
  final bool hasNextFetchError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: repoItems.length + (hasNext ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < repoItems.length) {
            return ListItem(repoItems: repoItems[index]);
          }
          if (hasNextFetchError) return _errorComponent(ref);
          return PaginationLoading(fetchMore: fetchNext);
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  Widget _errorComponent(WidgetRef ref) {
    final currentError = ref.read(searchStateNotifierProvider).maybeMap(
          fetchMoreFailure: (value) => value,
          orElse: () {
            throw AssertionError();
          },
        );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            currentError.exception is NoInternetException
                ? const Icon(Icons.wifi_off)
                : const Icon(Icons.error_outline),
            ElevatedButton(
              onPressed: () {
                fetchNext();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
              ),
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
