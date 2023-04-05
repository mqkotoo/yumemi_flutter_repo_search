import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/controller/controllers.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_count.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_list_view.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_app_bar.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_field.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //検索結果データ
    final repoData =
        ref.watch(repoDataProvider(ref.watch(inputRepoNameProvider)));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const SearchAppBar(),
        body: Column(
          children: <Widget>[
            //検索フォーム
            const SearchField(),
            const Divider(),
            //結果のリストビュー
            Expanded(
              flex: 8,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // result list item
                  ResultListview(repoData: repoData),
                  // // result count
                  if (ref.watch(isResultCountVisibleProvider))
                    if (!repoData.hasError &&
                        !repoData.isLoading &&
                        repoData.value!.totalCount != 0)
                      ResultCount(resultCount: repoData.value!.totalCount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
