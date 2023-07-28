import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/domain/repo_data_model.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/user_icon_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/detail/detail_page.dart';

class ListItem extends ConsumerWidget {
  const ListItem({Key? key, required this.repoItems}) : super(key: key);

  final RepoDataItems repoItems;

  @visibleForTesting
  static final userImageKey = UniqueKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //画像部分もタップできるように全体をGestureDetectorで囲む
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        //画像部分もタップできるように全体をGestureDetectorで囲む
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(repoData: repoItems),
            ),
          );
        },
        child: Row(
          children: [
            const SizedBox(width: 16), //16はListTileの横paddingと一緒の値
            //ListTileのleadingで画像を表示すると、縦が真ん中にならなかったのでこの方法で表示するようにする
            Hero(
              tag: repoItems,
              //user image icon
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 60,
                  height: 60,
                  imageUrl: repoItems.owner.avatarUrl,
                  placeholder: (_, __) => const UserIconShimmer(),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.error, size: 50),
                  key: userImageKey,
                ),
              ),
            ),
            // list tile
            Expanded(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    repoItems.fullName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Text(
                  repoItems.description ?? 'No Description',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
