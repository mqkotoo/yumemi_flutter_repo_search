import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'error_component.dart';

class EnterTextView extends StatelessWidget {
  const EnterTextView({Key? key}) : super(key: key);

  @visibleForTesting
  static final enterTextViewKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/20180-guy-typing.json',
      errorTitle: S.of(context).enterText,
      isNeedReloadButton: false,
      key: enterTextViewKey,
    );
  }
}

class NetworkErrorView extends StatelessWidget {
  const NetworkErrorView({Key? key}) : super(key: key);

  @visibleForTesting
  static final networkErrorViewKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/118789-no-internet.json',
      errorTitle: S.of(context).networkError,
      errorDetail: S.of(context).networkErrorDetail,
      isNeedReloadButton: true,
      key: networkErrorViewKey,
    );
  }
}

//ネットワークエラー以外のエラーの表示
class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @visibleForTesting
  static final errorViewKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/99345-error.json',
      errorTitle: S.of(context).errorOccurred,
      errorDetail: S.of(context).errorOccurredDetail,
      isNeedReloadButton: true,
      key: errorViewKey,
    );
  }
}

class NoResultView extends StatelessWidget {
  const NoResultView({Key? key}) : super(key: key);

  @visibleForTesting
  static final noResultViewKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ErrorComponent(
      lottieFile: 'assets/lottie_animation/106964-shake-a-empty-box.json',
      errorTitle: S.of(context).noResult,
      errorDetail: S.of(context).noResultDetail,
      isNeedReloadButton: false,
      key: noResultViewKey,
    );
  }
}
