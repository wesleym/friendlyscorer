import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

TextStyle? answerTileHeading(BuildContext context) {
  if (kIsWeb) {
    return Theme.of(context).textTheme.titleLarge;
  }

  if (Platform.isIOS) {
    return CupertinoTheme.of(context).textTheme.navTitleTextStyle;
  }

  if (Platform.isMacOS) {
    return MacosTheme.of(context).typography.headline;
  }

  return Theme.of(context).textTheme.titleLarge;
}

TextStyle? bodyStyle(BuildContext context) {
  if (kIsWeb) {
    return Theme.of(context).textTheme.bodyMedium;
  }

  if (Platform.isIOS) {
    return CupertinoTheme.of(context).textTheme.textStyle;
  }

  if (Platform.isMacOS) {
    return MacosTheme.of(context).typography.body;
  }

  return Theme.of(context).textTheme.bodyMedium;
}
