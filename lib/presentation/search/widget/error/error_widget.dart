import 'package:flutter/material.dart';

import 'error_conponent.dart';

class EnterTextView extends StatelessWidget {
  const EnterTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ErrorComponent(
      lottieFile: 'assets/lottie_animation/20180-guy-typing.json',
      errorTitle: 'テキストを入力してください。',
      key: Key('enterTextView'),
    );
  }
}

class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ErrorComponent(
      lottieFile: 'assets/lottie_animation/118789-no-internet.json',
      errorTitle: 'ネットワークエラーです。',
      errorDetail: '接続を確認して再度お試しください。',
      key: Key('networkErrorView'),
    );
  }
}
