import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../color/shimmer_color.dart';

class ListItemShimmer extends StatelessWidget {
  const ListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmerColor = Theme.of(context).extension<ShimmerColor>()!;
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 750),
        baseColor: shimmerColor.base!,
        highlightColor: shimmerColor.highlight!,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) => SafeArea(
            top: false,
            bottom: false,
            child: _listItem(),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }

  Widget _listItem() {
    return Row(
      children: [
        const SizedBox(width: 16),
        ClipOval(
          child: Container(
            width: 60,
            height: 60,
            color: const Color(0xFFE0E0E0),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                //title
                _shimmer(width: 150, height: 14),
                const SizedBox(height: 10)
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _shimmer(width: double.infinity, height: 12),
                const SizedBox(height: 6),
                _shimmer(width: double.infinity, height: 12)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _shimmer({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}
