import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

// class PaginationLoading extends StatelessWidget {
//   const PaginationLoading({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 30.0),
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

class PaginationLoading extends StatelessWidget {
  const PaginationLoading(this.onVisible, {super.key});

  final VoidCallback onVisible;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('for detect visibility'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          onVisible();
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
