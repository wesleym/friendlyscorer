import 'package:flutter/cupertino.dart';

const playerColors = [
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  // CupertinoColors.systemMint,
  // CupertinoColors.systemTeal,
  // CupertinoColors.systemCyan,
  CupertinoColors.systemBlue,
  // CupertinoColors.systemPink,
  CupertinoColors.systemPurple,
  // CupertinoColors.systemIndigo,
  // CupertinoColors.systemBrown,
  CupertinoColors.systemGrey,
];

class PlayerIdVendor {
  var currentId = 0;

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
  var currentId = 0;

  int next() => currentId++;
}
