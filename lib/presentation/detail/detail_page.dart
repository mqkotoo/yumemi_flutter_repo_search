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
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細ページ'),
      ),
      body: Column(
        children: [
          ClipOval(
            child: Image.network(
              repoData.owner.avatarUrl,
              width: 120,
              height: 120,
            ),
          ),
          Text(repoData.fullName),
          Text(repoData.description ?? 'No Description'),
          Text(repoData.language ?? 'No Language'),
          Text('star: $starsCount'),
          Text('watch: $watchersCount'),
          Text('fork: $forksCount'),
          Text('issue: $issuesCount'),
        ],
      ),
    );
  }
}
