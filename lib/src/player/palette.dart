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
  if (kIsWeb) {
    return materialPlayerColors;
  }

  if (Platform.isIOS) {
    return cupertinoPlayerColors;
  }

  if (Platform.isMacOS) {
    return switch (MacosTheme.of(context).brightness) {
      Brightness.dark => darkMacPlayerColors,
      Brightness.light => lightMacPlayerColors,
    };
  }

  return materialPlayerColors;
}

class PlayerIdVendor {
  static PlayerIdVendor? _instance;

  var currentId = 0;

  PlayerIdVendor._();

  factory PlayerIdVendor() => _instance ??= PlayerIdVendor._();

  int next() => currentId++;
}

const letterForId = {
  0: 'A',
  1: 'B',
  2: 'C',
  3: 'D',
  4: 'E',
  5: 'F',
  6: 'G',
  7: 'H',
  8: 'I',
  9: 'J',
  10: 'K',
  11: 'L',
  12: 'M',
  13: 'N',
  14: 'O',
  15: 'P',
  16: 'Q',
  17: 'R',
  18: 'S',
  19: 'T',
  20: 'U',
  21: 'V',
  22: 'W',
  23: 'X',
  24: 'Y',
  25: 'Z',
};

class RuleIdVendor {
  static RuleIdVendor? _instance;

  var currentId = 0;

  RuleIdVendor._();

  factory RuleIdVendor() => _instance ??= RuleIdVendor._();

  int next() => currentId++;
}
