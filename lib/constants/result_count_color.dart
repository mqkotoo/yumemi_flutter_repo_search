import 'package:flutter/material.dart';

@immutable
class ResultCountColor extends ThemeExtension<ResultCountColor> {
  const ResultCountColor({
    required this.background,
    required this.count,
  });

  final Color? background;
  final Color? count;

  @override
  ResultCountColor copyWith({
    Color? background,
    Color? count,
  }) {
    return ResultCountColor(
      background: background ?? this.background,
      count: count ?? this.count,
    );
  }

  // Controls how the properties change on theme changes
  @override
  ResultCountColor lerp(ThemeExtension<ResultCountColor>? other, double t) {
    if (other is! ResultCountColor) {
      return this;
    }
    return ResultCountColor(
      background: Color.lerp(background, other.background, t),
      count: Color.lerp(count, other.count, t),
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  @override
  String toString() => 'ResultCountColor('
      'background: $background, count: $count'
      ')';

  // the light theme
  static const light = ResultCountColor(
    background: Color(0xBF1A1C19),
    count: Color(0xffFCFDF6),
  );

  // the dark theme
  static const dark = ResultCountColor(
    background: Color(0xBFFCFDF6),
    count: Color(0xff1A1C19),
  );
}
