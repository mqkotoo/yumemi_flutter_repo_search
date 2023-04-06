import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class UserIconShimmer extends StatelessWidget {
  const UserIconShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 500),
      baseColor: const Color(0xffe0e0e0),
      highlightColor: const Color(0xffeeeeee),
      child: Container(color: const Color(0xFFE0E0E0)),
    );
  }
}
