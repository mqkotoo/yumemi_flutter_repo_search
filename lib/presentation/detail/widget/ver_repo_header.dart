import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/user_icon_shimmer.dart';

class VerRepoHeader extends StatelessWidget {
  const VerRepoHeader({Key? key, required this.repoData}) : super(key: key);

  final RepoDataItems repoData;

  //テスト用KEY
  @visibleForTesting
  static final userImageKey = UniqueKey();
  @visibleForTesting
  static final repoDetailKey = UniqueKey();
  @visibleForTesting
  static final repoNameKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: widthSize * 0.05),
      child: Column(
        children: [
          Hero(
            tag: repoData,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: repoData.owner.avatarUrl,
                width: 120,
                height: 120,
                placeholder: (_, __) => const UserIconShimmer(),
                errorWidget: (_, __, ___) => const Icon(Icons.error, size: 50),
                key: userImageKey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              repoData.fullName,
              style: Theme.of(context).textTheme.titleLarge,
              key: repoNameKey,
            ),
          ),
          Text(
            repoData.description ?? 'No Description',
            style: Theme.of(context).textTheme.titleSmall,
            key: repoDetailKey,
          ),
        ],
      ),
    );
  }
}
