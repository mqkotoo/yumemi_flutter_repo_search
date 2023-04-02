import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                    child: Image.network(
                      repoData.owner.avatarUrl,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      repoData.fullName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    repoData.description ?? 'No Description',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Divider(),
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
                  ),
                  detailElement(
                    icon: Icons.info_outline,
                    elementLabel: 'issue',
                    elementData: issuesCount,
                    iconBackgroundColor: Colors.green,
                    iconColor: Colors.white,
                  ),
                  SizedBox(height: 60)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailElement(
      {required Color iconBackgroundColor,
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
