import 'package:flutter/material.dart';

class PaginationLoading extends StatelessWidget {
  const PaginationLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
