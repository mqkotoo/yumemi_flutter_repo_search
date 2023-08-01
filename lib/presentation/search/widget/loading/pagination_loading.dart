import 'package:flutter/material.dart';

import 'package:visibility_detector/visibility_detector.dart';

class PaginationLoading extends StatelessWidget {
  const PaginationLoading({
    Key? key,
    required this.fetchMore,
  }) : super(key: key);

  final void Function() fetchMore;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('for detect visibility'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          fetchMore();
        }
      },
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
