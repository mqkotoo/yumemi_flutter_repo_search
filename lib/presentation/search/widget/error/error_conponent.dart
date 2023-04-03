import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

///エラーや入力を促す際の表示のフォーマット
class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    Key? key,
    required this.lottieFile,
    required this.errorTitle,
    this.errorDetail,
    this.lottieWidth,
  }) : super(key: key);

  final String lottieFile;
  final String errorTitle;
  final String? errorDetail;
  final double? lottieWidth;

  @override
  Widget build(BuildContext context) {
    // //デバイスの高さ取得
    // final deviceHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            lottieFile,
            // fit: BoxFit.fill,
            // width: lottieWidth ?? deviceHeight * 0.3,
            // height: deviceHeight * 0.3,
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
