import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

///エラーや入力を促す際の表示のフォーマット
class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    Key? key,
    required this.lottieFile,
    required this.errorTitle,
    this.errorDetail,
  }) : super(key: key);

  final String lottieFile;
  final String errorTitle;
  final String? errorDetail;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            lottieFile,
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 8),
          Text(
            errorTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          if (errorDetail != null) Text(errorDetail!),
        ],
      ),
    );
  }
}
