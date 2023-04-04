import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'error_conponent.dart';

class EnterTextView extends StatelessWidget {
  const EnterTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/20180-guy-typing.json',
      errorTitle: S.of(context).enterText,
      key: const Key('enterTextView'),
    );
  }
}

class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/118789-no-internet.json',
      errorTitle: S.of(context).networkError,
      errorDetail: S.of(context).networkErrorDetail,
      key: const Key('networkErrorView'),
    );
  }
}

//ネットワークエラー以外のエラーの表示
class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/99345-error.json',
      errorTitle: S.of(context).errorOccurred,
      errorDetail: S.of(context).errorOccurredDetail,
      key: const Key('errorView'),
    );
  }
}

class NoResultView extends StatelessWidget {
  const NoResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/106964-shake-a-empty-box.json',
      errorTitle: S.of(context).noResult,
      errorDetail: S.of(context).noResultDetail,
      key: const Key('noResultView'),
    );
  }
}
