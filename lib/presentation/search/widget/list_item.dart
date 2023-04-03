import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/user_icon_shimmer.dart';
import '../../../domain/repo_data_model.dart';
import '../../detail/detail_page.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    required this.repoData,
    required this.userIconUrl,
    required this.fullName,
    required this.description,
    Key? key,
  }) : super(key: key);

  final RepoDataItems repoData;
  final String userIconUrl;
  final String fullName;
  final String? description;

  @override
  Widget build(BuildContext context) {
    //画像部分もタップできるように全体をGestureDetectorで囲む
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(repoData: repoData)),
        );
      },
      child: Row(
        children: [
          const SizedBox(width: 16), //ListTileの横paddingと一緒の値
          //ListTileのleadingで画像を表示すると縦が真ん中にならなかったので、Rowで並べて表示するようにする
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: userIconUrl,
              width: 60,
              height: 60,
              placeholder: (_, __) => const UserIconShimmer(),
              errorWidget: (_, __, ___) => const Icon(Icons.error, size: 50),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                fullName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                description ?? 'No Description',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
