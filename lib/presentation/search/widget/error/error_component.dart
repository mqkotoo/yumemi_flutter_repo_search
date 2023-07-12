import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lottie/lottie.dart';

import '../../../provider/providers.dart';
import '../../search_state_notifier.dart';

///エラーや入力を促す際の表示のフォーマット
class ErrorComponent extends ConsumerWidget {
  const ErrorComponent(
      {Key? key,
      required this.lottieFile,
      required this.errorTitle,
      this.errorDetail,
      required this.isNeedReloadButton})
      : super(key: key);

  final String lottieFile;
  final String errorTitle;
  final String? errorDetail;
  final bool isNeedReloadButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //デバイスの高さ取得
    final deviceHeight = MediaQuery.of(context).size.height;

    final searchStateNotifier = ref.watch(searchStateNotifierProvider.notifier);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        //エラーコンポネント
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                lottieFile,
                width: deviceHeight * 0.3,
                height: deviceHeight * 0.3,
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
        ),
        //リロードボタン
        isNeedReloadButton
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    searchStateNotifier
                        .searchRepositories(ref.watch(inputRepoNameProvider));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
