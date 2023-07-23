import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_flutter_repo_search/domain/error.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/search_state_notifier.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/pagination_loading.dart';

class PaginationListView extends ConsumerWidget {
  const PaginationListView({
    Key? key,
    required this.itemCount,
    required this.hasNext,
    required this.fetchNext,
    required this.itemBuilder,
    required this.hasNextFetchError,
  }) : super(key: key);

  final int itemCount;
  final bool hasNext;
  final void Function() fetchNext;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool hasNextFetchError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchStateNotifierProvider);
    return Scrollbar(
      child: ListView.separated(
        itemCount: itemCount + (hasNext ? 1 : 0),
        itemBuilder: (context, index) {
          if (!hasNext || index < itemCount) {
            return itemBuilder(context, index);
          } else if (hasNextFetchError) {
            return _errorComponent(ref);
          }
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
                ? const Text('internet error')
                : const Text('too many request'),
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
