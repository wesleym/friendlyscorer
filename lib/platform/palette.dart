import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

Color platformAnswerColor(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoColors.systemFill;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosColors.controlBackgroundColor.resolveFrom(context);
  } else {
    return Theme.of(context).colorScheme.primaryContainer;
  }
}

Color platformCanvasColor(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoColors.systemBackground;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosTheme.of(context).canvasColor;
  } else {
    return Theme.of(context).colorScheme.background;
  }
}

Color platformDanger(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoColors.destructiveRed;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosColors.appleRed;
  } else {
    return Colors.red;
  }
}

Color ontoPlatformDanger(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoColors.label;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosColors.labelColor;
  } else {
    return Theme.of(context).colorScheme.onPrimary;
  }
}

Color ontoPlatformPlayer(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoColors.white;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosColors.white;
  } else {
    return Colors.white;
  }
}

Color ontoPlatformRule(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoColors.white;
  } else if (!kIsWeb && Platform.isMacOS) {
    return MacosColors.white;
  } else {
    return Colors.white;
  }
}

Color sectionHeadingColor() => CupertinoColors.inactiveGray;

Color shadowColor() => CupertinoColors.systemGrey;

Color newPlayerTileColor() => CupertinoColors.inactiveGray;

List<Color> answerCandidateChipColors() {
  return [
    CupertinoColors.systemGreen,
    CupertinoColors.activeOrange,
  ];
}

List<Color> ruleTileColors() {
  return [
    CupertinoColors.systemGreen,
    CupertinoColors.activeOrange,
  ];
}
