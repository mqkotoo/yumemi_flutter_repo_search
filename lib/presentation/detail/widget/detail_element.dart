import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class DetailElement extends StatelessWidget {
  const DetailElement(
      {required this.language,
      required this.star,
      required this.watch,
      required this.fork,
      required this.issue,
      Key? key})
      : super(key: key);

  final String? language;
  final String star;
  final String watch;
  final String fork;
  final String issue;

  //テスト用KEY
  @visibleForTesting
  static final languageKey = UniqueKey();
  @visibleForTesting
  static final starKey = UniqueKey();
  @visibleForTesting
  static final watchKey = UniqueKey();
  @visibleForTesting
  static final forkKey = UniqueKey();
  @visibleForTesting
  static final issueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        detailElement(
          icon: Icons.language,
          elementLabel: S.of(context).language,
          elementData: language ?? 'No Language',
          iconBackgroundColor: Colors.blueAccent,
          iconColor: Colors.white,
          key: languageKey,
        ),
        detailElement(
          icon: Icons.star_outline,
          elementLabel: S.of(context).star,
          elementData: star,
          iconBackgroundColor: Colors.yellowAccent,
          iconColor: Colors.black87,
          key: starKey,
        ),
        detailElement(
          icon: Icons.remove_red_eye_outlined,
          elementLabel: S.of(context).watch,
          elementData: watch,
          iconBackgroundColor: Colors.brown,
          iconColor: Colors.white,
          key: watchKey,
        ),
        detailElement(
          icon: Icons.fork_right_sharp,
          elementLabel: S.of(context).fork,
          elementData: fork,
          iconBackgroundColor: Colors.purpleAccent,
          iconColor: Colors.white,
          key: forkKey,
        ),
        detailElement(
          icon: Icons.info_outline,
          elementLabel: S.of(context).issue,
          elementData: issue,
          iconBackgroundColor: Colors.green,
          iconColor: Colors.white,
          key: issueKey,
        ),
      ],
    );
  }
}

Widget detailElement(
    {required Color iconBackgroundColor,
    required IconData icon,
    required Color iconColor,
    required String elementLabel,
    required String elementData,
    required Key key}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    key: key,
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: iconBackgroundColor,
          child: Icon(icon, size: 25, color: iconColor),
        ),
        const SizedBox(width: 12),
        Text(elementLabel, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text(
          elementData,
          style: const TextStyle(fontSize: 16),
        )
      ],
    ),
  );
}
