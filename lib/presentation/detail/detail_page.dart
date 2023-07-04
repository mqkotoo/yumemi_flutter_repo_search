import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:yumemi_flutter_repo_search/presentation/detail/widget/detail_element.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/widget/hori_repo_header.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/widget/ver_repo_header.dart';
import '../../domain/repo_data_model.dart';
import '../../generated/l10n.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.repoData, Key? key}) : super(key: key);

  final RepoDataItems repoData;

  //テスト用のKEY
  @visibleForTesting
  static final detailPageAppBarKey = UniqueKey();
  @visibleForTesting
  static final viewOnGithubKey = UniqueKey();

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
        key: detailPageAppBarKey,
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
                const SizedBox(height: 30),
                githubLinkText(context),
                const SizedBox(height: 50),
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
                const SizedBox(height: 30),
                githubLinkText(context),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //githubページに飛ばすテキスト
  Widget githubLinkText(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => _openGitHubUrl(Uri.parse(repoData.htmlUrl)),
        child: Text(
          S.of(context).viewOnGitHub,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blueAccent,
          ),
          key: viewOnGithubKey,
        ),
      ),
    );
  }

  //GitHubのリンク先に飛ばす
  Future<void> _openGitHubUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      throw Exception('このURLにはアクセスできません');
    }
  }
}
