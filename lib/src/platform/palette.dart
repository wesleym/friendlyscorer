import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

Color platformAnswerColor(BuildContext context) {
  if (kIsWeb) {
    return Theme.of(context).colorScheme.surface;
  }

  if (Platform.isIOS) {
    return CupertinoTheme.of(context).primaryContrastingColor;
  }

  if (Platform.isMacOS) {
    // TODO: This isn't exactly appropriate. The background should be white or
    // black, and these should probably be canvas.
    return MacosTheme.of(context).dividerColor;
  }

  return Theme.of(context).colorScheme.surface;
}
