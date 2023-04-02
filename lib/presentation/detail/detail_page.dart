import 'package:flutter/material.dart';

import '../../domain/repo_data_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.repoData, Key? key}) : super(key: key);

  final RepoDataItems repoData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('詳細ページ'),
      ),
      body: Column(
        children: [
          Text(repoData.fullName),
          Text(repoData.forksCount.toString()),
        ],
      ),
    );
  }
}
