import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:yumemi_flutter_repo_search/presentation/detail/widget/detail_element.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/widget/hori_repo_header.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/widget/ver_repo_header.dart';
import '../../domain/repo_data_model.dart';
import '../../generated/l10n.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.repoData, Key? key}) : super(key: key);

  final RepoDataItems repoData;

  @override
  Widget build(BuildContext context) {
    // データの数をカンマ区切りで表示
    final starsCount = NumberFormat('#,##0').format(repoData.stargazersCount);
    final watchersCount = NumberFormat('#,##0').format(repoData.watchersCount);
    final forksCount = NumberFormat('#,##0').format(repoData.forksCount);
    final issuesCount = NumberFormat('#,##0').format(repoData.openIssuesCount);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(S.of(context).detailPageTitle),
        key: const Key('detailPageAppBar'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < constraints.maxHeight
              ? verBody(
                  context, starsCount, watchersCount, forksCount, issuesCount)
              : horiBody(
                  context, starsCount, watchersCount, forksCount, issuesCount);
        },
      ),
    );
  }

  Widget verBody(BuildContext context, String starsCount, String watchersCount,
      String forksCount, String issuesCount) {
    //画面サイズ取得
    final widthSize = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          //リポジトリのヘッダー
          VerRepoHeader(repoData: repoData),
          const Divider(),
          //リポジトリのスター数などの要素
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 16, horizontal: widthSize * 0.05),
            child: Column(
              children: [
                DetailElement(
                  language: repoData.language,
                  star: starsCount,
                  watch: watchersCount,
                  fork: forksCount,
                  issue: issuesCount,
                ),
                const SizedBox(height: 60)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget horiBody(BuildContext context, String starsCount, String watchersCount,
      String forksCount, String issuesCount) {
    //画面サイズ取得
    final widthSize = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          //リポジトリのヘッダー
          HoriRepoHeader(repoData: repoData),
          const Divider(),
          //リポジトリのスター数などの要素
          Container(
            padding:
                EdgeInsets.symmetric(vertical: 16, horizontal: widthSize * 0.1),
            child: Column(
              children: [
                DetailElement(
                  language: repoData.language,
                  star: starsCount,
                  watch: watchersCount,
                  fork: forksCount,
                  issue: issuesCount,
                ),
                const SizedBox(height: 60)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
