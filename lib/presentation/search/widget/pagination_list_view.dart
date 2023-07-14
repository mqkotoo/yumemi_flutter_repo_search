import 'package:flutter/material.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/pagination_loading.dart';

class PaginationListView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        child: ListView.separated(
          itemCount: itemCount + (hasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (!hasNext || index < itemCount) {
              return itemBuilder(context, index);
            } else if (hasNextFetchError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.wifi_off),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          fetchNext();
                        },
                        child: const Text('再読み込み'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const PaginationLoading();
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
        onNotification: (notification) {
          if (notification.metrics.atEdge &&
              notification.metrics.extentAfter == 0) {
            if (hasNextFetchError) {
              return false;
            }
            fetchNext();
          }
          return false;
        },
      ),
    );
  }
}
