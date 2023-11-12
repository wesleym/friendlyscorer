import 'package:flutter/cupertino.dart';

const playerColors = [
  CupertinoColors.systemBlue,
  CupertinoColors.systemBrown,
  CupertinoColors.systemCyan,
  CupertinoColors.systemGreen,
  CupertinoColors.systemIndigo,
  CupertinoColors.systemMint,
  CupertinoColors.systemOrange,
  CupertinoColors.systemPink,
  CupertinoColors.systemPurple,
  CupertinoColors.systemRed,
  CupertinoColors.systemTeal,
  CupertinoColors.systemYellow,
];

class PlayerColorVendor {
  var currentIndex = 0;

  Color next() {
    return playerColors[currentIndex++];
  }
}
