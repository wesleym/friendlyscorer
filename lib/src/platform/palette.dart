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
    return CupertinoTheme.of(context).primaryContrastingColor;
  }

  if (Platform.isMacOS) {
    // TODO: This isn't exactly appropriate. The background should be white or
    // black, and these should probably be canvas.
    return MacosTheme.of(context).dividerColor;
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
    // TODO: This isn't exactly appropriate. The background should be white or
    // black, and these should probably be canvas.
    return MacosTheme.of(context).dividerColor;
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
