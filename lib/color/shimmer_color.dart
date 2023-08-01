import 'package:flutter/material.dart';

@immutable
class ShimmerColor extends ThemeExtension<ShimmerColor> {
  const ShimmerColor({
    required this.base,
    required this.highlight,
  });

  final Color? base;
  final Color? highlight;

  @override
  ShimmerColor copyWith({
    Color? base,
    Color? highlight,
  }) {
    return ShimmerColor(
      base: base ?? this.base,
      highlight: highlight ?? this.highlight,
    );
  }

  // Controls how the properties change on theme changes
  @override
  ShimmerColor lerp(ThemeExtension<ShimmerColor>? other, double t) {
    if (other is! ShimmerColor) {
      return this;
    }
    return ShimmerColor(
      base: Color.lerp(base, other.base, t),
      highlight: Color.lerp(highlight, other.highlight, t),
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  @override
  String toString() => 'ShimmerColor('
      'base: $base, highlight: $highlight'
      ')';

  // the light theme
  static const light = ShimmerColor(
    base: Color(0xffe0e0e0),
    highlight: Color(0xffeeeeee),
  );

  // the dark theme
  static const dark = ShimmerColor(
    base: Color(0xff616161),
    highlight: Color(0xff757575),
  );
}
