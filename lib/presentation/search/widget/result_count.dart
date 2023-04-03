import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

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
          color: const Color(0xFF1A1C19).withOpacity(0.6),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '${NumberFormat('#,##0').format(resultCount)}件',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
