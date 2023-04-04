import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../search/widget/user_icon_shimmer.dart';

class VerRepoHeader extends StatelessWidget {
  const VerRepoHeader(
      {Key? key,
      required this.avatarUrl,
      required this.fullName,
      required this.description})
      : super(key: key);

  final String avatarUrl;
  final String fullName;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: widthSize * 0.05),
      child: Column(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              width: 120,
              height: 120,
              placeholder: (_, __) => const UserIconShimmer(),
              errorWidget: (_, __, ___) => const Icon(Icons.error, size: 50),
              key: const Key('userImage'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              fullName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            description ?? 'No Description',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}