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
          key: const Key('language'),
        ),
        detailElement(
          icon: Icons.star_outline,
          elementLabel: S.of(context).star,
          elementData: star,
          iconBackgroundColor: Colors.yellowAccent,
          iconColor: Colors.black87,
          key: const Key('star'),
        ),
        detailElement(
          icon: Icons.remove_red_eye_outlined,
          elementLabel: S.of(context).watch,
          elementData: watch,
          iconBackgroundColor: Colors.brown,
          iconColor: Colors.white,
          key: const Key('watch'),
        ),
        detailElement(
          icon: Icons.fork_right_sharp,
          elementLabel: S.of(context).fork,
          elementData: fork,
          iconBackgroundColor: Colors.purpleAccent,
          iconColor: Colors.white,
          key: const Key('fork'),
        ),
        detailElement(
          icon: Icons.info_outline,
          elementLabel: S.of(context).issue,
          elementData: issue,
          iconBackgroundColor: Colors.green,
          iconColor: Colors.white,
          key: const Key('issue'),
        ),
        const SizedBox(height: 60)
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
          child: Icon(icon, size: 20, color: iconColor),
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
