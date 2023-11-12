import 'package:flutter/cupertino.dart';

const playerColors = [
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  CupertinoColors.systemTeal,
  CupertinoColors.systemBlue,
  CupertinoColors.systemPink,
  CupertinoColors.systemPurple,
  CupertinoColors.systemBrown,
  // CupertinoColors.systemCyan,
  // CupertinoColors.systemIndigo,
  // CupertinoColors.systemMint,
];

class PlayerColorVendor {
  var currentIndex = 0;

  Color next() {
    return playerColors[currentIndex++];
  }
}
