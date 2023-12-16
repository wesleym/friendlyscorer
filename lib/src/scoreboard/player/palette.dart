import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

const cupertinoPlayerColors = [
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  CupertinoColors.systemMint,
  CupertinoColors.systemTeal,
  CupertinoColors.systemCyan,
  CupertinoColors.systemBlue,
  CupertinoColors.systemPink,
  CupertinoColors.systemPurple,
  CupertinoColors.systemIndigo,
  CupertinoColors.systemBrown,
  // CupertinoColors.systemGrey,
];

final lightMacPlayerColors = [
  MacosColors.appleRed,
  MacosColors.appleOrange,
  MacosColors.appleYellow,
  MacosColors.appleGreen,
  MacosColors.appleCyan,
  MacosColors.appleBlue,
  MacosColors.appleMagenta,
  MacosColors.applePurple,
  MacosColors.appleBrown,
  // CupertinoColors.systemGrey,
].map((c) {
  final hslColor = HSLColor.fromColor(c);
  return hslColor
      .withLightness(clampDouble(hslColor.lightness + 0.1, 0, 1))
      .toColor();
}).toList(growable: false);

final darkMacPlayerColors = [
  MacosColors.appleRed,
  MacosColors.appleOrange,
  MacosColors.appleYellow,
  MacosColors.appleGreen,
  MacosColors.appleCyan,
  MacosColors.appleBlue,
  MacosColors.appleMagenta,
  MacosColors.applePurple,
  MacosColors.appleBrown,
  // CupertinoColors.systemGrey,
].map((c) {
  final hslColor = HSLColor.fromColor(c);
  return hslColor
      .withLightness(clampDouble(hslColor.lightness - 0.2, 0, 1))
      .toColor();
}).toList(growable: false);

final materialPlayerColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  // The grey swatch is intentionally omitted because when picking a color
  // randomly from this list to colorize an application, picking grey suddenly
  // makes the app look disabled.
  Colors.blueGrey,
];

List<Color> playerColors(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return cupertinoPlayerColors;
  } else if (!kIsWeb && Platform.isMacOS) {
    return switch (MacosTheme.of(context).brightness) {
      Brightness.dark => darkMacPlayerColors,
      Brightness.light => lightMacPlayerColors,
    };
  } else {
    return materialPlayerColors;
  }
}
