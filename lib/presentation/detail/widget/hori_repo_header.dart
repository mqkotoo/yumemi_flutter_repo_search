import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../search/widget/user_icon_shimmer.dart';

class HoriRepoHeader extends StatelessWidget {
  const HoriRepoHeader(
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
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: widthSize * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          SizedBox(
            width: widthSize * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  description ?? 'No Description',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
