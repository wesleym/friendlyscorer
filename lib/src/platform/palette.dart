import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

Color platformAnswerColor(BuildContext context) {
  if (kIsWeb) {
    return Theme.of(context).colorScheme.primaryContainer;
  }

  if (Platform.isIOS) {
    return CupertinoColors.systemFill;
  }

  if (Platform.isMacOS) {
    return MacosColors.controlBackgroundColor.resolveFrom(context);
  }

  return Theme.of(context).colorScheme.primaryContainer;
}

Color platformCanvasColor(BuildContext context) {
  if (kIsWeb) {
    return Theme.of(context).colorScheme.background;
  }

  if (Platform.isIOS) {
    return CupertinoColors.systemBackground;
  }

  if (Platform.isMacOS) {
    return MacosTheme.of(context).canvasColor;
  }

  return Theme.of(context).colorScheme.background;
}

Color platformDanger(BuildContext context) {
  if (kIsWeb) {
    return Colors.red;
  }

  if (Platform.isIOS) {
    return CupertinoColors.destructiveRed;
  }

  if (Platform.isMacOS) {
    return MacosColors.appleRed;
  }

  return Colors.red;
}

Color ontoPlatformDanger(BuildContext context) {
  if (kIsWeb) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  if (Platform.isIOS) {
    return CupertinoColors.label;
  }

  if (Platform.isMacOS) {
    return MacosColors.labelColor;
  }

  return Theme.of(context).colorScheme.onPrimary;
}

Color ontoPlatformPlayer(BuildContext context) {
  if (kIsWeb) {
    return Colors.white;
  }

  if (Platform.isIOS) {
    return CupertinoColors.white;
  }

  if (Platform.isMacOS) {
    return MacosColors.white;
  }

  return Colors.white;
}
