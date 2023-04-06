import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../domain/repo_data_model.dart';
import '../../search/widget/user_icon_shimmer.dart';

class HoriRepoHeader extends StatelessWidget {
  const HoriRepoHeader({Key? key, required this.repoData}) : super(key: key);

  final RepoDataItems repoData;

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: widthSize * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                key: const Key('userImageOnDetailPage'),
              ),
            ),
          ),
          SizedBox(
            width: widthSize * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  repoData.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                  key: const Key('repoNameOnDetailPage'),
                ),
                const SizedBox(height: 10),
                Text(
                  repoData.description ?? 'No Description',
                  style: Theme.of(context).textTheme.titleSmall,
                  key: const Key('repoDetailOnDetailPage'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
