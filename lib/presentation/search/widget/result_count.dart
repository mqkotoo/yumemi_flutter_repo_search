import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../constants/app_color.dart';

class ResultCount extends StatelessWidget {
  const ResultCount({required this.resultCount, Key? key}) : super(key: key);

  final int resultCount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColor.lightBgColor
              : AppColor.darkBgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '${NumberFormat('#,##0').format(resultCount)}件',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColor.lightCountColor
                : AppColor.darkCountColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          key: const Key('resultCount'),
        ),
      ),
    );
  }
}