import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/user_icon_shimmer.dart';

import '../../domain/repo_data_model.dart';

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

    //画面サイズ取得
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('詳細ページ'),
        key: const Key('detailPageAppBar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 16, horizontal: widthSize * 0.05),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    key: const Key('userImageOnDetailPage'),
                    child: CachedNetworkImage(
                      imageUrl: repoData.owner.avatarUrl,
                      width: 120,
                      height: 120,
                      placeholder: (_, __) => const UserIconShimmer(),
                      errorWidget: (_, __, ___) =>
                          const Icon(Icons.error, size: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      repoData.fullName,
                      style: Theme.of(context).textTheme.titleLarge,
                      key: const Key('repoNameOnDetailPage'),
                    ),
                  ),
                  Text(
                    repoData.description ?? 'No Description',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 16, horizontal: widthSize * 0.05),
              child: Column(
                children: [
                  detailElement(
                    icon: Icons.language,
                    elementLabel: 'language',
                    elementData: repoData.language ?? 'No Language',
                    iconBackgroundColor: Colors.blueAccent,
                    iconColor: Colors.white,
                  ),
                  detailElement(
                    icon: Icons.star_outline,
                    elementLabel: 'star',
                    elementData: starsCount,
                    iconBackgroundColor: Colors.yellowAccent,
                    iconColor: Colors.black87,
                  ),
                  detailElement(
                    icon: Icons.remove_red_eye_outlined,
                    elementLabel: 'watch',
                    elementData: watchersCount,
                    iconBackgroundColor: Colors.brown,
                    iconColor: Colors.white,
                  ),
                  detailElement(
                      icon: Icons.fork_right_sharp,
                      elementLabel: 'fork',
                      elementData: forksCount,
                      iconBackgroundColor: Colors.purpleAccent,
                      iconColor: Colors.white,
                      key: const Key('fork')),
                  detailElement(
                    icon: Icons.info_outline,
                    elementLabel: 'issue',
                    elementData: issuesCount,
                    iconBackgroundColor: Colors.green,
                    iconColor: Colors.white,
                  ),
                  const SizedBox(height: 60)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailElement(
      {Key? key,
      required Color iconBackgroundColor,
      required IconData icon,
      required Color iconColor,
      required String elementLabel,
      required String elementData}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBackgroundColor,
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Text(elementLabel, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(
            elementData,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
