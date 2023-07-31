import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import 'package:yumemi_flutter_repo_search/color/shimmer_color.dart';

class UserIconShimmer extends StatelessWidget {
  const UserIconShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shimmerColor = Theme.of(context).extension<ShimmerColor>()!;
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 750),
      baseColor: shimmerColor.base!,
      highlightColor: shimmerColor.highlight!,
      child: Container(color: const Color(0xFFE0E0E0)),
    );
  }
}
