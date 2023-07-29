import 'package:flutter/material.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/result_view.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_app_bar.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const SearchAppBar(),
        body: Column(
          children: const <Widget>[
            //検索フォーム
            SearchBar(),
            Divider(),
            //検索結果のリスト表示部分
            Expanded(flex: 8, child: ResultView())
          ],
        ),
      ),
    );
  }
}
