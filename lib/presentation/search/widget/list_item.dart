import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yumemi_flutter_repo_search/presentation/search/widget/list_item_shimmer.dart';
import 'package:yumemi_flutter_repo_search/presentation/search/widget/user_icon_shimmer.dart';
import '../../controller/controllers.dart';
import '../../detail/detail_page.dart';
import 'error/error_widget.dart';

class ListItem extends ConsumerWidget {
  const ListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.read(listIndexProvider);
    final repoData = ref.watch(repoAtIndexProvider(index));
    //画像部分もタップできるように全体をGestureDetectorで囲む
    return SafeArea(
      top: false,
      bottom: false,
      child: repoData.when(
        data: (data) => GestureDetector(
          //画像部分もタップできるように全体をGestureDetectorで囲む
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(repoData: data),
              ),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 16), //16はListTileの横paddingと一緒の値
              //ListTileのleadingで画像を表示すると、縦が真ん中にならなかったのでこの方法で表示するようにする
              Hero(
                tag: data,
                //user image icon
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 60,
                    height: 60,
                    imageUrl: data.owner.avatarUrl,
                    placeholder: (_, __) => const UserIconShimmer(),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.error, size: 50),
                    key: const Key('userImageOnListView'),
                  ),
                ),
              ),
              // list tile
              Expanded(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      data.fullName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    data.description ?? 'No Description',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const ListItemShimmer(),
        error: (e, _) {
          switch (e) {
            case 'No Keywords':
              return const EnterTextView();
            case 'Network Error':
              return const NetworkErrorView();
            case 'Error Occurred':
              return const ErrorView();
            default:
              throw Exception(e);
          }
        },
      ),
    );
  }
}
