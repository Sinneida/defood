import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

ColorScheme generateColorScheme(Color primaryColor, [Brightness? brightness]) {
  final Color seedColor = primaryColor;

  final ColorScheme newScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness ?? Brightness.light,
  );
  return newScheme.harmonized();
}
